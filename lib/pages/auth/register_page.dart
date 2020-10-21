import 'package:absensi/api/service.dart';
import 'package:absensi/models/auth/cls_post_register.dart';
import 'package:absensi/pages/auth/login.dart';
import 'package:absensi/pages/general_widget.dart/widget_progress.dart';
import 'package:absensi/pages/general_widget.dart/widget_snackbar.dart';
import 'package:absensi/pages/main_menu.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController ctrlEmail = new TextEditingController();
  TextEditingController ctrlPassword = new TextEditingController();
  TextEditingController ctrlNamaDepan = new TextEditingController();
  TextEditingController ctrlNamaBelakang = new TextEditingController();

  Future submitRegister(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => WidgetProgressSubmit());
    ModelPostEditRegisterPassword dataSubmit =
        new ModelPostEditRegisterPassword();
    dataSubmit.isRegister = true;
    dataSubmit.email = ctrlEmail.text;
    dataSubmit.password = ctrlPassword.text;
    dataSubmit.namaDepan = ctrlNamaDepan.text;
    dataSubmit.namaBelakang = ctrlNamaBelakang.text;
    getClient().postNewRegister(dataSubmit).then((res) async {
      Navigator.pop(context);
      if (res.statusJson) {
        pref.setString("PREF_TOKEN", res.token);
        pref.setString("PREF_ID_USER", res.dataUser.iduser);
        pref.setString("PREF_EMAIL", res.dataUser.email);
        pref.setString("PREF_NAMA_DEPAN", res.dataUser.namaDepan);
        pref.setString("PREF_NAMA_BELAKANG", res.dataUser.namaBelakang);
        navigateToHome();
      } else {
        displayDialog(res.remarks);
      }
    }).catchError((Object obj) {
      Navigator.pop(context);
      print(obj.toString());
      WidgetSnackbar(
          context: context,
          message: "Failed connect to server!",
          warna: "merah");
    });
  }

  checkMandatory() {
    if (ctrlEmail.text.isEmpty) {
      return "Silakan isi email";
    } else if (ctrlPassword.text.isEmpty) {
      return "Silakan isi password";
    } else if (ctrlNamaDepan.text.isEmpty) {
      return "Silakan isi nama depan anda";
    } else {
      return "";
    }
  }

  displayDialog(String remarks) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Info')),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  //USERNAME FIELD
                  Text(remarks)
                ]),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.screenLeftRight1, bottom: 8),
                child: Container(
                  width: SizeConfig.screenWidth * 0.3,
                  child: SizedBox(
                    height: SizeConfig.screenHeight * 0.045,
                    child: RaisedButton(
                      onPressed: () {
                        goToLogin();
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: ColorsTheme.primary1,
                      child: Text(
                        "OK",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: SizeConfig.fontSize4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MainMenu()),
        (Route<dynamic> route) => false);
  }

  goToLogin() {
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginPage();
        },
      ),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight * 0.125,
            ),
            Center(
              child: Image.asset(
                "assets/ilustration/register.png",
                fit: BoxFit.cover,
                width: SizeConfig.screenWidth * 0.7,
              ),
            ),
            Text(
              "ABSENSI SYSTEM",
              style: TextStyle(
                  color: ColorsTheme.text1,
                  fontSize: SizeConfig.fontSize8,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "by INVOSA",
              style: TextStyle(
                  color: ColorsTheme.text2,
                  fontSize: SizeConfig.fontSize5,
                  fontStyle: FontStyle.italic),
            ),
            SizedBox(
              height: SizeConfig.screenHeight * 0.05,
            ),
            field(Icons.email, ctrlEmail, "Email", TextInputType.emailAddress,
                false),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            field(
                Icons.lock, ctrlPassword, "Password", TextInputType.text, true),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            field(Icons.person, ctrlNamaDepan, "Nama Depan", TextInputType.text,
                false),
            SizedBox(
              height: SizeConfig.screenHeight * 0.01,
            ),
            field(Icons.person, ctrlNamaBelakang, "Nama Belakang",
                TextInputType.text, false),
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
                        submitRegister(context);
                      } else {
                        FocusScope.of(context).requestFocus(FocusNode());
                        WidgetSnackbar(
                            context: context, message: check, warna: "merah");
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: ColorsTheme.primary1,
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white, fontSize: SizeConfig.fontSize4),
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
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Sudah punya akun ? ",
                      style: TextStyle(
                          color: ColorsTheme.text2,
                          fontSize: SizeConfig.fontSize4),
                    ),
                    Text(
                      " Silakan login",
                      style: TextStyle(
                          color: ColorsTheme.primary2,
                          fontSize: SizeConfig.fontSize4),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget field(IconData iconData, TextEditingController ctrl, String hintText,
    TextInputType inputType, bool obscureText) {
  return Padding(
    padding: EdgeInsets.only(
        left: SizeConfig.screenLeftRight3, right: SizeConfig.screenLeftRight3),
    child: Container(
      decoration: BoxDecoration(
        color: ColorsTheme.background2,
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: SizeConfig.screenLeftRight1),
        child: Row(
          children: <Widget>[
            Icon(iconData),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                obscureText: obscureText,
                keyboardType: inputType,
                controller: ctrl,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: hintText),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
