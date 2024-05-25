import 'dart:convert';
import 'package:e_commerce/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../provider/data_provider.dart';

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment(
      String paymentAmount, BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent(paymentAmount, 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  billingDetails: const BillingDetails(
                      name: 'YOUR NAME',
                      email: 'YOUREMAIL@gmail.com',
                      phone: 'YOUR NUMBER',
                      address: Address(
                          city: 'YOUR CITY',
                          country: 'YOUR COUNTRY',
                          line1: 'YOUR ADDRESS 1',
                          line2: 'YOUR ADDRESS 2',
                          postalCode: 'YOUR PINCODE',
                          state: 'YOUR STATE')),
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Testing'))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(context);
    } catch (e) {
      print(e.toString());
      // Fluttertoast.showToast(msg: e.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      // Fluttertoast.showToast(msg: 'Payment succesfully completed');
      var itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
      itemsProvider.setPaymentStatus(doneText);
      itemsProvider.emptyCart();
    } on Exception catch (e) {
      if (e is StripeException) {
        // Fluttertoast.showToast(
        //     msg: 'Error from Stripe: ${e.error.localizedMessage}');
        var itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
        itemsProvider.setPaymentStatus("${e.error.localizedMessage}");
      } else {
        var itemsProvider = Provider.of<ItemsProvider>(context, listen: false);
        itemsProvider.setPaymentStatus("Error: Payment Failed!");
        // Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
      }
    }
  }

//create Payment
  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51OtDkq1dKZ8EyNgBGEIqJpOx7K401ibMcQb3PfBmvCUATFlfOM82jPRIPNHY9Tw3qKKuHSnTl6k5AiFR4nw6YvmS002NrPQEHy',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
