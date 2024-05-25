import 'package:delayed_display/delayed_display.dart';
import '../services/authentication_services.dart';
import 'package:e_commerce/provider/data_provider.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../theme.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/input_field.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  bool _nameFieldError = false;
  bool _emailFieldError = false;
  bool _passwordFieldError = false;
  bool _confirmationFieldError = false;

  String? validateName(String? name) {
    if (name!.isEmpty) {
      _nameFieldError = true;
      return 'Please enter your name.';
    } else if (name.length < 4) {
      _nameFieldError = true;
      return 'Name must be at least 4 characters.';
    }
    _nameFieldError = false;
    return null;
  }

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

  String? validateConfirmation(
    String? confirmation,
  ) {
    if (confirmation!.isEmpty) {
      _confirmationFieldError = true;
      return 'Please re-enter your password.';
    } else if (confirmation.length < 8) {
      _confirmationFieldError = true;
      return 'Invalid password.';
    } else if (confirmation != _passwordController.text.toString()) {
      _confirmationFieldError = true;
      return 'Passwords don\'t match';
    }
    _confirmationFieldError = false;
    return null;
  }

  int countError() {
    int errors = 0;
    if (_confirmationFieldError) {
      errors++;
    }
    if (_nameFieldError) {
      errors++;
    }
    if (_emailFieldError) {
      errors++;
    }
    if (_passwordFieldError) {
      errors++;
    }
    return errors;
  }

  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    _emailFieldError = false;
    _passwordFieldError = false;
    _nameFieldError = false;
    _confirmationFieldError = false;
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
                      "Ready To Dive In?",
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        fontWeight: FontWeight.w100,
                        color: const Color.fromARGB(213, 255, 255, 255),
                      ),
                    )),
                    Container(
                      height: countError() == 4
                          ? 490
                          : countError() == 3
                              ? 450
                              : countError() == 2
                                  ? 430
                                  : countError() == 1
                                      ? 410
                                      : 390,
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
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyInputField(
                                    title: "Name",
                                    controller: _nameController,
                                    validator: validateName,
                                    error: _nameFieldError,
                                    prefixIcon: FluentIcons.person_48_regular,
                                    keyboardType: TextInputType.emailAddress),
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
                                MyInputField(
                                    title: "Confirm Password",
                                    controller: _confirmationController,
                                    validator: validateConfirmation,
                                    error: _confirmationFieldError,
                                    prefixIcon: FluentIcons.key_32_regular,
                                    obscureText: true),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.only(right: 10.0),
                                //   child: Align(
                                //     alignment: Alignment.centerRight,
                                //     child: TextButton(
                                //         onPressed: () {},
                                //         child: Text(
                                //           "Forgot Password?",
                                //           style: GoogleFonts.lato(
                                //             color: buttonColor,
                                //           ),
                                //         )),
                                //   ),
                                // ),
                                MyGradientButton(
                                    text: "SIGN UP",
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Form is valid, proceed with login logic
                                        String email = _emailController.text;
                                        String password =
                                            _passwordController.text;
                                        String name = _nameController.text;
                                        AuthenticationServices obj =
                                            AuthenticationServices();
                                        obj.signUp(
                                            name, email, password, context);
                                        print("object");
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
                                  ? "Already have an Account?"
                                  : screenWidth > 270
                                      ? "Have Account?"
                                      : "",
                              style: GoogleFonts.lato(fontSize: 12),
                            ),
                            TextButton(
                                onPressed: () {
                                  authProvider.screenSetter(AuthScreen.login);
                                },
                                child: Text(
                                  "Sign In",
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
