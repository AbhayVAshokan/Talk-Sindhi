// Forgot Password Screen

import 'package:flutter/material.dart';

import '../widgets/login-register/submit_button.dart';
import '../widgets/login-register/input_textformfield.dart';

class ForgotPassword extends StatefulWidget {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _emailAddress = "";

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    final double width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 37.5),
                width: screenRatio < 1 ? width * 0.75 : width * 0.9,
                height: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 60.0,
                              bottom: 20.0,
                            ),
                            child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                  text: 'S',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.red, fontSize: 30.0),
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
                            ),
                          ),
                          Form(
                            key: ForgotPassword._formKey,
                            child: Column(
                              children: [
                                inputTextFormField(
                                  context: context,
                                  labelText: 'Email',
                                  data: _emailAddress,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (newValue) =>
                                      _emailAddress = newValue,
                                  validation: (String email) {
                                    if (!RegExp(
                                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                        .hasMatch(email)) {
                                      return 'Enter valid email address';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SubmitButton(
                            text: 'NEXT',
                            width: constraints.maxWidth * 0.4,
                            color: Colors.pink,
                            onTap: () {},
                          ),  
                          Divider(color: Theme.of(context).backgroundColor),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, '/register'),
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
              Positioned(
                top: 0,
                left: 10.0,
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Theme.of(context).backgroundColor,
                    child: Image.asset(
                      'assets/images/splash_screen/powerd_by_logo.png',
                      width: 75.0,
                      height: 75.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
