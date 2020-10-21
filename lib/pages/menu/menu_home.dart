import 'package:absensi/api/service.dart';
import 'package:absensi/models/menu/cls_absen.dart';
import 'package:absensi/pages/general_widget.dart/widget_cari.dart';
import 'package:absensi/pages/general_widget.dart/widget_error.dart';
import 'package:absensi/pages/general_widget.dart/widget_loading_page.dart';
import 'package:absensi/pages/menu/absen.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuHome extends StatefulWidget {
  @override
  _MenuHomeState createState() => _MenuHomeState();
}

class _MenuHomeState extends State<MenuHome> {
  bool loading;
  bool failed;
  String remakrs;
  DataAbsen dataAbsenIn;
  DataAbsen dataAbsenOut;
  String email;
  String namaDepan;
  String namaBelakang;
  String tanggal;

  Future getData() async {
    setState(() {
      loading = true;
      failed = false;
    });
    DateTime now = DateTime.now();
    SharedPreferences pref = await SharedPreferences.getInstance();
    getClient().getHome(pref.getString("PREF_TOKEN")).then((res) async {
      if (res.statusJson) {
        setState(() {
          tanggal = DateFormat('dd-MM-yyyy').format(now);
          email = pref.getString("PREF_EMAIL");
          namaDepan = pref.getString("PREF_NAMA_DEPAN");
          namaBelakang = pref.getString("PREF_NAMA_BELAKANG");
          dataAbsenIn = res.dataAbsenIn;
          dataAbsenOut = res.dataAbsenOut;
          loading = false;
          failed = false;
        });
      } else {
        setState(() {
          loading = false;
          failed = true;
          remakrs = res.remarks;
        });
      }
    }).catchError((Object obj) {
      setState(() {
        loading = false;
        failed = true;
        remakrs = "Gagal menyambungkan ke server";
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? WidgetLoadingPage()
        : failed
            ? WidgetErrorConnection(
                onRetry: () {
                  setState(() {
                    getData();
                  });
                },
                remarks: remakrs)
            : RefreshIndicator(
                // ignore: missing_return
                onRefresh: () {
                  getData();
                },
                child: Scaffold(
                  body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: SizeConfig.screenHeight * 0.275,
                          color: ColorsTheme.primary1,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenLeftRight1,
                              right: SizeConfig.screenLeftRight1,
                              top: SizeConfig.screenHeight * 0.05),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      " Hi",
                                      style: TextStyle(
                                          fontFamily: 'BalsamiqSans',
                                          fontSize: 24,
                                          color: Colors.white),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      " " + namaDepan,
                                      style: TextStyle(
                                          fontFamily: 'BalsamiqSans',
                                          fontSize: 24,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.notifications_active,
                                color: ColorsTheme.kuning,
                                size: SizeConfig.screenWidth * 0.1,
                              ),
                              SizedBox(
                                width: 8,
                              )
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenLeftRight1,
                                right: SizeConfig.screenLeftRight1,
                                top: SizeConfig.screenHeight * 0.175),
                            child: Column(
                              children: <Widget>[
                                Card(
                                    elevation: 2,
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            tanggal,
                                            style: TextStyle(
                                                // fontFamily: 'BalsamiqSans',
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              inOut(
                                                  "IN",
                                                  "assets/images/in.png",
                                                  dataAbsenIn == null
                                                      ? "0"
                                                      : dataAbsenIn.jam),
                                              SizedBox(
                                                width: SizeConfig.screenWidth *
                                                    0.2,
                                              ),
                                              inOut(
                                                  "OUT",
                                                  "assets/images/out.png",
                                                  dataAbsenOut == null
                                                      ? "0"
                                                      : dataAbsenOut.jam)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                  height: 16,
                                ),
                                Card(
                                  elevation: 2,
                                  child: ClipPath(
                                    clipper: ShapeBorderClipper(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4))),
                                    child: Container(
                                      // height: 100,
                                      width: SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: ColorsTheme.primary1,
                                                  width: 5))),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Informasi Pribadi",
                                              style: TextStyle(
                                                  fontFamily: 'BalsamiqSans',
                                                  fontSize: 18,
                                                  color: ColorsTheme.text1),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            buildRowInfoPribadi("Email",
                                                email == null ? "" : email),
                                            buildRowInfoPribadi(
                                                "Nama Depan",
                                                namaDepan == null
                                                    ? ""
                                                    : namaDepan),
                                            buildRowInfoPribadi(
                                                "Nama Belakang",
                                                namaBelakang == null
                                                    ? ""
                                                    : namaBelakang),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.screenHeight * 0.1,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32)),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Absen()));
                                  },
                                  color: ColorsTheme.primary1,
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 20, bottom: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/images/absen.png",
                                        fit: BoxFit.cover,
                                        width: SizeConfig.screenWidth * 0.1,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        "ABSEN",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              );
  }
}

Widget inOut(String inOut, String icon, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          inOut,
          style: TextStyle(
              fontFamily: 'BalsamiqSans',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.01,
        ),
        Image.asset(
          icon,
          fit: BoxFit.cover,
          width: SizeConfig.screenWidth * 0.1,
        ),
        SizedBox(
          height: SizeConfig.screenHeight * 0.015,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            value == "0" || value == null || value == "" ? "-" : value,
            style: TextStyle(
                fontFamily: 'BalsamiqSans',
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

Widget buildRowInfoPribadi(String key, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: <Widget>[
          Container(width: SizeConfig.screenWidth * 0.3, child: Text(key)),
          Text(
            " : " + value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      SizedBox(height: 8)
    ],
  );
}
