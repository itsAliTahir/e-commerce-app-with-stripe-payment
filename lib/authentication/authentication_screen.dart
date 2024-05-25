import 'package:e_commerce/authentication/widgets/forgot_password_widget.dart';
import 'package:e_commerce/authentication/widgets/login_widget.dart';
import 'package:e_commerce/authentication/widgets/register_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../provider/data_provider.dart';
import '../theme.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: gradientScreen,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: Container(
              //     margin:
              //         const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              //     child: Opacity(
              //       opacity: 0.3,
              //       child: Lottie.asset(
              //         'assets/animations/space.json',
              //         width: double.infinity,
              //         height: 300,
              //         repeat: true,
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  child: Image.asset(
                    "assets/images/login_buildings.png",
                    color: const Color.fromARGB(255, 206, 206, 206),
                  ),
                ),
              ),
              authProvider.currentScreen == AuthScreen.login
                  ? LoginScreen()
                  : authProvider.currentScreen == AuthScreen.register
                      ? RegisterScreen()
                      : authProvider.currentScreen == AuthScreen.forgotPassword
                          ? ForgotPasswordScreen()
                          : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
