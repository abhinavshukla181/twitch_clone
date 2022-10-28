import 'package:flutter/material.dart';
import 'package:twitch_clone/resources/auth_methods.dart';
import 'package:twitch_clone/screens/HomeScreen.dart';
import 'package:twitch_clone/widgets/custom_button.dart';
import 'package:twitch_clone/widgets/custom_textfield.dart';
import 'package:twitch_clone/widgets/loading_indicator.dart';

class SignUpScreen extends StatefulWidget {
  static const String routName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final TextEditingController _usernameContoller = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  bool _isloading = false;

  void signUpUser() async {
    setState(() {
      _isloading = true;
    });
    bool res = await _authMethods.signUpUser(context, _emailContoller.text,
        _usernameContoller.text, _passwordContoller.text);
    setState(() {
      _isloading = false;
    });
    if (res) {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }

  @override
  void dispose() {
    _emailContoller.dispose();
    _usernameContoller.dispose();
    _passwordContoller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; //it will adjust the size of extra space according to various screens
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: _isloading
          ? const LoadingIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1),
                    const Text(
                      'Email',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _emailContoller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'username',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _usernameContoller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Password',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: CustomTextField(controller: _passwordContoller),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(onTap: signUpUser, text: 'Sign Up'),
                  ],
                ),
              ),
            ),
    );
  }
}
