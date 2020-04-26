import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../realtime_data.dart';
import '../login-register/input_textformfield.dart';
import '../login-register/submit_button.dart';

requestPasswordChange({
  @required oldPassword,
  @required newPassword,
}) async {
  var response = await http.post(
    Uri.encodeFull('http://204.48.26.50:8033/user/changePassword'),
    headers: {
      'Accept': 'application/json',
      'Authorization': authToken,
    },
    body: {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    },
  );

  var jsonResponse = json.decode(response.body);

  if (jsonResponse['status'] == true) {
    Fluttertoast.showToast(
      msg: "Successfully updated password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  } else
    Fluttertoast.showToast(
      msg: "Wrong password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
}

// Check internet connectivity asynchronously.
Future<ConnectivityResult> checkConnectivity() async {
  return await (Connectivity().checkConnectivity());
}

changePassword({
  BuildContext context,
  formkey,
  ConnectivityResult connectivityResult,
}) {
  String oldPassword;
  String newPassword;
  String confirmPassword;

  return showDialog(
    context: context,
    child: AlertDialog(
      backgroundColor: Colors.red[50],
      title: Column(
        children: [
          FittedBox(
            child: const Text(
              'CHANGE PASSWORD',
              style: const TextStyle(
                color: Colors.pinkAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.75,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Form(
            key: formkey,
            child: Column(
              children: [
                inputTextFormField(
                  context: context,
                  labelText: 'Old password',
                  data: oldPassword,
                  validation: (String password) {
                    if (password.isEmpty)
                      return 'Should not be null';
                    else
                      return null;
                  },
                  obscureText: true,
                  prefixIcon: Icons.lock_outline,
                  onChanged: (newValue) => oldPassword = newValue,
                ),
                inputTextFormField(
                  context: context,
                  labelText: 'New Password',
                  data: newPassword,
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  textInputAction: TextInputAction.next,
                  onChanged: (newValue) {
                    newPassword = newValue;
                  },
                  validation: (String input) {
                    bool _checkNumber() {
                      int flag = 0;
                      for (var i = 0; i < input.length; i++) {
                        if ("1234567890".contains(input[i])) flag = 1;
                      }
                      if (flag == 1)
                        return true;
                      else
                        return false;
                    }

                    bool _checkCharacter() {
                      int flag = 0;
                      for (var i = 0; i < input.length; i++) {
                        if ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
                            .contains(input[i])) flag = 1;
                      }
                      if (flag == 1)
                        return true;
                      else
                        return false;
                    }

                    if (input.length < 8)
                      return "Must contain atleast 8 characters";
                    else if (!_checkNumber())
                      return "Must contain atleast one digit";
                    else if (!_checkCharacter())
                      return "Must contain atleast one character";
                    else
                      return null;
                  },
                ),
                inputTextFormField(
                  context: context,
                  labelText: 'Confirm Password',
                  prefixIcon: Icons.security,
                  data: confirmPassword,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  onChanged: (newValue) => confirmPassword = newValue,
                  validation: (String input) {
                    if (input != newPassword) {
                      return 'Passwords do not match';
                    } else
                      return null;
                  },
                ),
                const SizedBox(height: 20.0),
                Divider(color: Theme.of(context).backgroundColor),
                SubmitButton(
                  text: 'CHANGE PASSWORD',
                  width: 200,
                  color: Colors.pink,
                  onTap: () {
                    if (!formkey.currentState.validate()) return;

                    checkConnectivity()
                        .then((ConnectivityResult connectivityResult) {
                      if (!(connectivityResult == ConnectivityResult.wifi ||
                          connectivityResult == ConnectivityResult.mobile)) {
                        Fluttertoast.showToast(
                          msg: "No Network available",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black87,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      } else {
                        requestPasswordChange(
                            oldPassword: oldPassword, newPassword: newPassword);
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
