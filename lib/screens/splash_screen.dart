// Splash Screen: Duration = 3 seconds

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../realtime_data.dart';
import '../file_operations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();

    // Request for storage permission.
    _permissionHandler();

    // Load local data as real-time data
    loadLocalData();

    // Checking whether connected to internet or not
    checkConnectivity().then(
      (ConnectivityResult connectivityResult) async {
        if (connectivityResult == ConnectivityResult.wifi ||
            connectivityResult == ConnectivityResult.mobile) {
          // If internet connection is available update the local data from the server.
          var response = await http.post(
            Uri.encodeFull('http://204.48.26.50:8033/data/get'),
            headers: {
              'Accept': 'application/json',
            },
          );
          // Sync local data with server.
          syncWithServer(response);
        }
      },
    );

    Timer(
      Duration(seconds: 5),
      () async {
        // Checking whether the user had previously logged in. If yes, jump directly into the home screen.
        getApplicationDocumentsDirectory().then(
          (Directory dir) {
            var path = dir.path + '/userData.json';
            var jsonFile = File(path);
            if (jsonFile.existsSync()) {
              var localStorage = json.decode(jsonFile.readAsStringSync());
              userData = localStorage;
              if (localStorage['isLoggedIn'] == true)
                Navigator.pushReplacementNamed(context, '/home');
              else
              Navigator.pushReplacementNamed(context, '/login');
            } else
              Navigator.pushReplacementNamed(context, '/login');
          },
        );
      },
    );
  }

  // Request storage permission.
  _permissionHandler() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    final width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          'assets/images/splash_screen/splash_foreground.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: screenRatio < 1
                          ? (width / 2 - (height * 5 / 7) * 0.5)
                          : width * 0.13,
                      bottom: height * 0.075,
                    ),
                    child: Text(
                      'Speak \nSindhi',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: width / 2 - 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                      backgroundColor: Colors.white24,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Presented by,",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    child: Image.asset(
                      'assets/images/splash_screen/powerd_by_logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
