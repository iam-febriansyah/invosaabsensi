import 'dart:async';

import 'package:absensi/pages/auth/login.dart';
import 'package:absensi/pages/main_menu.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String version = "";
  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
    });
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var duration = const Duration(seconds: 3);
    return Timer(duration, () {
      if (preferences.getString("PREF_TOKEN") == null ||
          preferences.getString("PREF_TOKEN").isEmpty ||
          preferences.getString("PREF_TOKEN") == "") {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainMenu()),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenTopBottom1,
                  right: SizeConfig.screenTopBottom1),
              child: Image.asset(
                "assets/images/splash_screen.png",
                // fit: BoxFit.,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Container(
                    child: Text(
                  version,
                  style: TextStyle(fontSize: 16, color: ColorsTheme.text1),
                )),
              ))
        ],
      ),
    );
  }
}
