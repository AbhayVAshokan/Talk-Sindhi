// Login Screen

import 'package:flutter/material.dart';

import '../widgets/login-register/input_textfield.dart';
import '../widgets/login-register/submit_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    final double width = mediaQuery.size.width;
    final screenRatio = height / width;

    TextEditingController _emailAddressController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: <Widget>[
            Positioned(
              top: screenRatio < 1 ? height * 0.05 : height * 0.2,
              left: screenRatio < 1 ? width * 0.035 : width * 0.05,
              child: Container(
                width: screenRatio < 1 ? width * 0.75 : width * 0.9,
                height: screenRatio < 1 ? height * 0.9 : height * 0.6,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'S',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      color: Colors.red,
                                      fontSize: constraints.maxHeight * 0.075),
                              children: [
                                const TextSpan(
                                  text: 'PEAK ',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                const TextSpan(text: 'S'),
                                const TextSpan(
                                  text: 'INDHI',
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              InputTextField(
                                labelText: 'Email',
                                controller: _emailAddressController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              InputTextField(
                                labelText: 'Password',
                                controller: _passwordController,
                                obscureText: true,
                                textInputAction: TextInputAction.done,
                              ),
                              GestureDetector(
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: const Text(
                                    'Forgot Password?',
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      letterSpacing: 0.75,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(
                                text: 'FACEBOOK',
                                width: constraints.maxWidth * 0.4,
                                color: Colors.blue,
                                onTap: () {},
                              ),
                              Text(
                                'Or',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              SubmitButton(
                                text: 'LOGIN',
                                width: constraints.maxWidth * 0.4,
                                color: Colors.pink,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                              ),
                            ],
                          ),
                          Divider(color: Theme.of(context).backgroundColor),
                          GestureDetector(
                            child: Text(
                              'Don\'t have an account? Enroll now.',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
