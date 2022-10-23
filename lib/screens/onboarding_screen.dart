import 'package:flutter/material.dart';
import 'package:twitch_clone/screens/Login_screen.dart';
import 'package:twitch_clone/screens/Signup_screen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  static const routeName = '/onboarding';
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Welcome \n to Twitch',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.routName);
                },
                text: 'Log in'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.routName);
                },
                text: 'Sign Up'),
          ),
        ]),
      ),
    );
  }
}
