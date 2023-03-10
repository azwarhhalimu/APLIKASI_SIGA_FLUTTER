import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Data_siga.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Galeri.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Tentang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api_http/ApiGetVersionApp.dart';
import '../Componen/AlertDialog.dart';

class Halaman_utama extends StatefulWidget {
  static String routeName = "/";
  const Halaman_utama({super.key});

  @override
  State<Halaman_utama> createState() => _Halaman_utamaState();
}

class _Halaman_utamaState extends State<Halaman_utama> {
  List fragment = <Widget>[
    Home(),
    Galeri(),
    Data_siga(),
    Tentang(),
  ];
  int selected = 0;

  _pop() {
    if (selected > 0) {
      setState(() {
        selected = 0;
      });
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(40),
            height: 270,
            child: Column(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Apakah anda ini keluar dari aplikasi ini?"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Jangan dulu")),
                    ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text("Ya Keluar"))
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }

  Map<String, dynamic> data = {};
  _check() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    ApiGetVersionApp().then((value) {
      if (value == "terjadi_masalah") {
        Alert(
            context, "Terjadi masalah", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        Alert(context, "No Internet", "Periksa kembali koneksi internet anda");
      } else {
        setState(() {
          data = jsonDecode(value);
        });
        if (data["version"] > int.parse(packageInfo.buildNumber)) {
          setState(() {
            isUpdate = true;
          });
        }
      }
    });
  }

  bool isUpdate = false;
  @override
  void initState() {
    // TODO: implement initState
    _check();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SafeArea(
          top: isUpdate,
          child: Scaffold(
            body: Column(
              children: [
                isUpdate
                    ? Container(
                        color: Colors.red,
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Update terbaru aplikasi telah tersedia.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 10),
                                  ),
                                  Text("Klik tombol update untuk mengupdate",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (Platform.isAndroid || Platform.isIOS) {
                                    PackageInfo packageInfo =
                                        await PackageInfo.fromPlatform();
                                    final appId = Platform.isAndroid
                                        ? packageInfo.packageName
                                        : 'YOUR_IOS_APP_ID';
                                    print(appId);
                                    final url = Uri.parse(
                                      Platform.isAndroid
                                          ? "market://details?id=$appId"
                                          : "https://apps.apple.com/app/id$appId",
                                    );
                                    launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                child: Text(
                                  "Update",
                                  style: TextStyle(fontSize: 10),
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isUpdate = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Icon(
                                  Icons.close,
                                  size: 13,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Expanded(child: fragment[selected])
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (value) {
                setState(() {
                  selected = value;
                });
              },
              currentIndex: selected,
              selectedLabelStyle: TextStyle(fontSize: 12),
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.image_outlined), label: "Galeri"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.data_array), label: "Data Siga"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.info_outline), label: "Tentang"),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          return _pop();
        });
  }
}
