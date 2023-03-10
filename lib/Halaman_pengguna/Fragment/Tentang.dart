import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:siga2/Api_http/ApiGetVersionApp.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Tentang extends StatefulWidget {
  const Tentang({super.key});

  @override
  State<Tentang> createState() => _TentangState();
}

class _TentangState extends State<Tentang> {
  Map<String, dynamic> data = {};
  void _check() async {
    Loading_dialog(title: "Periksa version", context: context).show();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    ApiGetVersionApp().then((value) {
      Navigator.pop(context);
      if (value == "terjadi_masalah") {
        Alert(context, "Terjadi masalah", "Internal Error ");
      } else if (value == "no_internet") {
        Alert(context, "No Internet", "Periksa kembali sambungan anda");
      } else {
        data = jsonDecode(value);
        if (int.parse(packageInfo.buildNumber) < data["version"]) {
          showModalBottomSheet(
            isScrollControlled: true,
            isDismissible: data['status'] == "wajib" ? false : true,
            context: context,
            builder: (context) {
              return Container(
                height: 250,
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 70,
                    ),
                    Text("Versi baru sudah tersedia di PLAYSTORE"),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            if (Platform.isAndroid || Platform.isIOS) {
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
                          child: Text("Donwload Sekarang")),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Donwload Nanti")),
                  ],
                ),
              );
            },
          );
        } else {
          Alert(context, "Info", "Versi Aplikasi Anda Sudah Uptodate");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          "Tentang Aplikasi",
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.blue,
            child: Column(
              children: [
                Image.asset("assets/images/logo_siga.png",
                    width: MediaQuery.of(context).size.width * 0.3),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "SIGA KOTA BAUBAU",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sistim Informasi Gender dan Anak",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Dinas Pemberdayaan Perempuan dan Anal\nKota Baubau, Sulawesi Tenggara",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (() {
              Alert(
                context,
                "Tentang",
                "SISTIM INFOMASI GENDER DAN ANAK\n\nVERSION ${VERSI}\nCompileD by Google Flutter ${FLUTTER_VERSI}",
              );
            }),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(25, 0, 0, 0)))),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Tentang SIGA"), Icon(Icons.chevron_right)],
              ),
            ),
          ),
          InkWell(
            onTap: (() {
              _check();
            }),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(25, 0, 0, 0)))),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Periksa Update Terbaru"),
                  Icon(Icons.chevron_right)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
