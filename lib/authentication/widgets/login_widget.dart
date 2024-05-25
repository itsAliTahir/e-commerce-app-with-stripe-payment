import 'package:delayed_display/delayed_display.dart';
import '../services/authentication_services.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/data_provider.dart';
import '../../theme.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/input_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // Key for form validation
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _emailFieldError = false;
  bool _passwordFieldError = false;

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

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      _passwordFieldError = true;
      return 'Please enter your password.';
    } else if (password.length < 8) {
      _passwordFieldError = true;
      return 'Password must be at least 8 characters.';
    }
    _passwordFieldError = false;
    return null;
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFieldError = false;
    _passwordFieldError = false;
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
                      "Welcome Back!",
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: Color.fromARGB(213, 255, 255, 255),
                      ),
                    )),
                    Container(
                      height: _emailFieldError && _passwordFieldError
                          ? 330
                          : _emailFieldError || _passwordFieldError
                              ? 305
                              : 300,
                      margin: const EdgeInsets.all(5.0),
                      padding: EdgeInsets.symmetric(horizontal: 5),
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
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyInputField(
                                    title: "Email",
                                    controller: _emailController,
                                    validator: validateEmail,
                                    error: _emailFieldError,
                                    prefixIcon: FluentIcons.mail_48_regular,
                                    keyboardType: TextInputType.emailAddress),
                                MyInputField(
                                    title: "Password",
                                    controller: _passwordController,
                                    validator: validatePassword,
                                    error: _passwordFieldError,
                                    prefixIcon:
                                        FluentIcons.lock_closed_48_regular,
                                    obscureText: true),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                        onPressed: () {
                                          authProvider.screenSetter(
                                              AuthScreen.forgotPassword);
                                        },
                                        child: Text(
                                          "Forgot Password?",
                                          style: GoogleFonts.lato(
                                            color: buttonColor,
                                          ),
                                        )),
                                  ),
                                ),
                                MyGradientButton(
                                    text: "LOG IN",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Form is valid, proceed with login logic
                                        String email = _emailController.text;
                                        String password =
                                            _passwordController.text;
                                        // Implement your login logic here
                                        AuthenticationServices obj =
                                            AuthenticationServices();
                                        obj.login(email, password, context);
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
