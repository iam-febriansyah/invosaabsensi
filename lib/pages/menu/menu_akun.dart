import 'package:absensi/pages/auth/login.dart';
import 'package:absensi/pages/general_widget.dart/widget_error.dart';
import 'package:absensi/pages/general_widget.dart/widget_loading_page.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuAkun extends StatefulWidget {
  @override
  _MenuAkunState createState() => _MenuAkunState();
}

class _MenuAkunState extends State<MenuAkun> {
  String email = "";
  String namaDepan = "";
  String namaBelakang = "";
  String version = "";

  getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      version = info.version;
      email = pref.getString("PREF_EMAIL");
      namaDepan = pref.getString("PREF_NAMA_DEPAN");
      namaBelakang = pref.getString("PREF_NAMA_BELAKANG");
    });
  }

  displayDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text('Konfirmasi')),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 12,
                  ),
                  //USERNAME FIELD
                  Text("Anda yakin akan keluar aplikasi ?")
                ]),
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight1, bottom: 8),
                    child: Container(
                      width: SizeConfig.screenWidth * 0.3,
                      child: SizedBox(
                        height: SizeConfig.screenHeight * 0.045,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: BorderSide(color: ColorsTheme.primary1)),
                          color: Colors.white,
                          child: Text(
                            "TIDAK",
                            style: TextStyle(
                                color: ColorsTheme.primary1,
                                fontSize: SizeConfig.fontSize4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
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
                            "YA",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: SizeConfig.fontSize4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        });
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
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Container(
              height: SizeConfig.screenHeight * 0.4,
              color: ColorsTheme.primary1,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenLeftRight1,
                  right: SizeConfig.screenLeftRight1,
                  top: SizeConfig.screenHeight * 0.05),
              child: Text(
                " Akun",
                style: TextStyle(
                    fontFamily: 'BalsamiqSans',
                    fontSize: 24,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.screenHeight * 0.3),
              child: Container(
                // height: SizeConfig.screenHeight * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.15,
                    ),
                    card(context, Icons.email, "Email", email),
                    card(context, Icons.email, "Nama Depan", namaDepan),
                    card(context, Icons.email, "Nama Belakang", namaBelakang),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.075,
                    ),
                    GestureDetector(
                      onTap: () {
                        displayDialog();
                      },
                      child: Text(
                        "KELUAR",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsTheme.primary2),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.025,
                    ),
                    Text(
                      version == null ? "" : "Version " + version,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorsTheme.primary1),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.05,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.screenLeftRight1,
                  right: SizeConfig.screenLeftRight1,
                  top: SizeConfig.screenHeight * 0.2),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      height: SizeConfig.screenHeight * 0.175,
                      width: SizeConfig.screenWidth * 0.375,
                      child: CircleAvatar(
                        radius: SizeConfig.screenWidth * 0.2,
                        backgroundImage: AssetImage(
                          "assets/ilustration/avatar.png",
                          // fit: BoxFit.,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      namaDepan,
                      style: TextStyle(
                          fontFamily: 'BalsamiqSans',
                          fontSize: 24,
                          color: ColorsTheme.primary1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget card(BuildContext context, IconData icon, String key, String value) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
    child: Card(
      elevation: 2,
      child: ClipPath(
        clipper: ShapeBorderClipper(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
        child: Container(
          // height: 100,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: ColorsTheme.primary1, width: 5))),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  key,
                  style: TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontSize: 16,
                      color: ColorsTheme.background3),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  value,
                  style: TextStyle(
                      fontFamily: 'BalsamiqSans',
                      fontSize: 18,
                      color: ColorsTheme.text1),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
