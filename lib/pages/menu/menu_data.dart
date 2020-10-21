import 'package:absensi/api/service.dart';
import 'package:absensi/models/menu/cls_absen.dart';
import 'package:absensi/pages/general_widget.dart/widget_error.dart';
import 'package:absensi/pages/general_widget.dart/widget_loading_page.dart';
import 'package:absensi/style/colors.dart';
import 'package:absensi/style/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuData extends StatefulWidget {
  @override
  _MenuDataState createState() => _MenuDataState();
}

class _MenuDataState extends State<MenuData> {
  bool loading;
  bool failed;
  String remakrs;
  List<DataAbsen> dataAbsen = [];
  List<DataAbsen> dataAbsenTemp = [];

  Future getData() async {
    setState(() {
      loading = true;
      failed = false;
    });

    SharedPreferences pref = await SharedPreferences.getInstance();
    getClient().getListAbensi(pref.getString("PREF_TOKEN")).then((res) async {
      if (res.statusJson) {
        setState(() {
          dataAbsen = res.dataAbsen;
          dataAbsenTemp = dataAbsen;
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

  void filter() {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
              title: Center(child: Text('Cari Data')),
              content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenLeftRight0,
                          right: SizeConfig.screenLeftRight0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsTheme.background2,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.screenLeftRight1),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.search),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: TextField(
                                  onChanged: _onChange,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Cari ...'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenLeftRight1,
                      right: SizeConfig.screenLeftRight1,
                      bottom: 8),
                  child: Container(
                    width: SizeConfig.screenWidth,
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 0.045,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        color: ColorsTheme.primary1,
                        child: Text(
                          "CARI",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.fontSize4),
                        ),
                      ),
                    ),
                  ),
                )
              ]);
        });
  }

  _onChange(String value) {
    setState(() {
      if (value == "" || value == null) {
        dataAbsen = dataAbsen;
      } else {
        dataAbsen = dataAbsenTemp != null
            ? dataAbsenTemp
                .where((field) =>
                    field.tanggal.toLowerCase().contains(value.toLowerCase()) ||
                    field.jam.toLowerCase().contains(value.toLowerCase()) ||
                    field.inOut.toLowerCase().contains(value.toLowerCase()) ||
                    field.lokasi.toLowerCase().contains(value.toLowerCase()))
                .toList()
            : dataAbsenTemp;
      }
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
                child: Stack(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight0,
                        right: SizeConfig.screenLeftRight0,
                        top: SizeConfig.screenHeight * 0.15),
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: ListView.builder(
                        padding: EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        primary: true,
                        itemCount: dataAbsen.length,
                        itemBuilder: (BuildContext content, int index) {
                          return buildCardList(context, dataAbsen[index]);
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * 0.125,
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
                                " Histori Absensi",
                                style: TextStyle(
                                    fontFamily: 'BalsamiqSans',
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenLeftRight1,
                        right: SizeConfig.screenLeftRight1,
                        top: SizeConfig.screenHeight * 0.095),
                    child: InkWell(
                      onTap: () {
                        filter();
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.01,
                                right: SizeConfig.screenWidth * 0.005,
                                top: SizeConfig.screenHeight * 0.01,
                                bottom: SizeConfig.screenHeight * 0.01),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.search,
                                  color: ColorsTheme.primary1,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Text(
                                    "Cari",
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: ColorsTheme.text2,
                                        fontSize: SizeConfig.fontSize3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]));
  }
}

Widget buildCardList(BuildContext context, DataAbsen dataAbsen) {
  String latitude =
      dataAbsen.latitude == null ? "Latitude missing" : dataAbsen.latitude;
  String longitude =
      dataAbsen.longitude == null ? "Longitude missing" : dataAbsen.longitude;
  String pin = latitude + ", " + longitude;
  return Card(
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
                right: BorderSide(
                    color: dataAbsen.inOut == "IN"
                        ? ColorsTheme.primary1
                        : ColorsTheme.primary2,
                    width: 5))),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: SizeConfig.screenWidth * 0.2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(dataAbsen.tanggal,
                              style: TextStyle(
                                  fontSize: 12, color: ColorsTheme.text1)),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            dataAbsen.inOut,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: dataAbsen.inOut == "IN"
                                    ? ColorsTheme.primary1
                                    : ColorsTheme.primary2),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(dataAbsen.jam,
                              style: TextStyle(
                                  fontSize: 12, color: ColorsTheme.text1)),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: ColorsTheme.background3,
                      thickness: 1,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            buildRowInfoPribadi(
                                "STATUS",
                                dataAbsen.isWfh == null
                                    ? ""
                                    : dataAbsen.isWfh == "1"
                                        ? "Work From Home"
                                        : "Work From Office"),
                            buildRowInfoPribadi(
                                "ALAMAT",
                                dataAbsen.lokasi == null
                                    ? ""
                                    : dataAbsen.lokasi),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Icon(
                                  Icons.place,
                                  color: Colors.red,
                                  size: SizeConfig.screenWidth * 0.035,
                                ),
                                Text(
                                  pin,
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildRowInfoPribadi(String key, String value) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              width: SizeConfig.screenWidth * 0.15,
              child: Text(key, style: TextStyle(fontSize: 12))),
          Text(" : "),
          Expanded(
            child: Container(
              child: Text(
                value,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 4,
      )
    ],
  );
}
