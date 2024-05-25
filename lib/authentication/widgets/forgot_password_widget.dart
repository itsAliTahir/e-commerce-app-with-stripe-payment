import 'package:delayed_display/delayed_display.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../theme.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/input_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _emailController = TextEditingController();
  bool _emailFieldError = false;

  String? validateEmail(String? email) {
    final emailRegex = RegExp(
        r"[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+");
    if (email!.isEmpty) {
      _emailFieldError = true;
      return 'Please enter your email address.';
    } else if (!emailRegex.hasMatch(email)) {
      _emailFieldError = true;
      return 'Please enter a valid email address.';
    }
    _emailFieldError = false;
    return null;
  }

  void dispose() {
    _emailController.dispose();
    _emailFieldError = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: DelayedDisplay(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(
                      "FORGOT YOUR PASS?",
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: const Color.fromARGB(213, 255, 255, 255),
                      ),
                    )),
                    Container(
                      height: _emailFieldError ? 280 : 260,
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      // color: Colors.white,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        elevation: 8,
                        child: Form(
                          key: _formKey, // Assign key to the Form widget
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "We'll send instructions on how to reset your password to the email address you have registered with us",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.lato(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                MyInputField(
                                    title: "Email",
                                    controller: _emailController,
                                    validator: validateEmail,
                                    error: _emailFieldError,
                                    prefixIcon: FluentIcons.mail_48_regular,
                                    keyboardType: TextInputType.emailAddress),
                                MyGradientButton(
                                    text: "SEND",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Form is valid, proceed with login logic

                                        // Implement your login logic here
                                      }
                                      setState(() {});
                                    }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      margin: const EdgeInsets.all(5.0),
                      padding: EdgeInsets.all(8),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.white,
                        surfaceTintColor: Colors.transparent,
                        elevation: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              screenWidth > 313
                                  ? "Don't have an Account?"
                                  : screenWidth > 270
                                      ? "No Account?"
                                      : "",
                              style: GoogleFonts.lato(fontSize: 12),
                            ),
                            TextButton(
                                onPressed: () {
                                  authProvider
                                      .screenSetter(AuthScreen.register);
                                },
                                child: Text(
                                  "Register Now",
                                  style: GoogleFonts.lato(
                                      color: buttonColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
