import 'package:absensi/api/service.dart';
import 'package:absensi/models/auth/cls_post_login.dart';
import 'package:absensi/pages/auth/register_page.dart';
import 'package:absensi/pages/general_widget.dart/widget_progress.dart';
import 'package:absensi/pages/general_widget.dart/widget_snackbar.dart';
import 'package:absensi/pages/main_menu.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController ctrlemail = new TextEditingController();
  TextEditingController ctrlPassword = new TextEditingController();

  Future submitLogin(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WidgetProgressSubmit());
    ModelPostLogin dataSubmit = new ModelPostLogin();
    dataSubmit.email = ctrlemail.text;
    dataSubmit.password = ctrlPassword.text;
    getClient().postLogin(dataSubmit).then((res) async {
      Navigator.pop(context);
      if (res.statusJson) {
        pref.setString("PREF_TOKEN", res.token);
        pref.setString("PREF_ID_USER", res.dataUser.iduser);
        pref.setString("PREF_EMAIL", res.dataUser.email);
        pref.setString("PREF_NAMA_DEPAN", res.dataUser.namaDepan);
        pref.setString("PREF_NAMA_BELAKANG", res.dataUser.namaBelakang);
        navigateToHome();
      } else {
        WidgetSnackbar(context: context, message: res.remarks, warna: "merah");
      }
    }).catchError((Object obj) {
      print(obj.toString());
      Navigator.pop(context);
      WidgetSnackbar(
          context: context,
          message: "Failed connect to server!",
          warna: "merah");
    });
  }

  checkMandatory() {
    if (ctrlemail.text.isEmpty) {
      return "Silakan isi Email";
    } else if (ctrlPassword.text.isEmpty) {
      return "Silakan isi Password";
    } else {
      return "";
    }
  }

  clearPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainMenu()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    clearPref();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
          color: Colors.white,
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      "assets/ilustration/login.png",
                      fit: BoxFit.cover,
                      width: SizeConfig.screenWidth * 0.7,
                    ),
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        "ABSENSI SYSTEM",
                        style: TextStyle(
                            fontFamily: 'BalsamiqSans',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.075,
                  ),

                  //email FIELD
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight3,
                        right: SizeConfig.screenLeftRight3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsTheme.background2,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.screenLeftRight1),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.email),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                controller: ctrlemail,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Email'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.01,
                  ),
                  //PASSWORD FIELD
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight3,
                        right: SizeConfig.screenLeftRight3),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ColorsTheme.background2,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: SizeConfig.screenLeftRight1),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.lock),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextField(
                                controller: ctrlPassword,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: SizeConfig.screenHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight3,
                        right: SizeConfig.screenLeftRight3),
                    child: Container(
                      width: SizeConfig.screenWidth,
                      child: SizedBox(
                        height: SizeConfig.screenHeight * 0.045,
                        child: RaisedButton(
                          onPressed: () {
                            String check = checkMandatory();
                            if (check == "") {
                              submitLogin(context);
                            } else {
                              FocusScope.of(context).requestFocus(FocusNode());
                              WidgetSnackbar(
                                  context: context,
                                  message: check,
                                  warna: "merah");
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          color: ColorsTheme.primary1,
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.fontSize4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Belum punya akun ? ",
                            style: TextStyle(
                                color: ColorsTheme.text2,
                                fontSize: SizeConfig.fontSize4),
                          ),
                          Text(
                            " Klik disini",
                            style: TextStyle(
                                color: ColorsTheme.primary2,
                                fontSize: SizeConfig.fontSize4),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.015,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
