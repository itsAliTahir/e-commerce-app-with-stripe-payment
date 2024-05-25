import 'package:e_commerce/authentication/authentication_screen.dart';
import 'package:e_commerce/bottom_navigation_bar_services.dart';
import 'package:e_commerce/cart/cart_screen.dart';
import 'package:e_commerce/cart/services/stripe_payment_screen.dart';
import 'package:e_commerce/provider/data_provider.dart';
import 'package:e_commerce/authentication/splash_screen.dart';
import 'package:e_commerce/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:e_commerce/routes_name.dart';
import 'package:flutter/material.dart';
import 'item_detail/item_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51OtDkq1dKZ8EyNgBSSVwM2RmAJp59Mqi0GPMkNzbSkYOv2Qbuxc6UAEcFkdZqxJaWcvO4r9eIi4XpfucBj5uB5ky000yI2EhK8";
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ItemsProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          // Define the ThemeData with your focused border color
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100), gapPadding: 10,
              borderSide: BorderSide(
                  width: 1.5,
                  color: buttonColor), // Set your focused border color
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          splashScreen: (context) => const SplashScreen(),
          authenticationScreen: (context) => AuthenticationScreen(),
          homeScreen: (context) => const BottomNavigationBarServices(),
          itemDetailScreen: (context) => const ItemDetailScreen(),
          cartScreen: (context) => CartScreen(),
          paymentScreen: (context) => const PaymentScreen(),
        },
      ),
    );
  }
}
