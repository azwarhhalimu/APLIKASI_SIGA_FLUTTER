import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:siga2/Api_http/ApiGetVersionApp.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Halaman_pengguna/Halaman_utama.dart';

import 'Componen/AlertDialog.dart';

import 'package:url_launcher/url_launcher.dart';

class SplashScreenmain extends StatefulWidget {
  static String routeName = "/spld";
  const SplashScreenmain({super.key});

  @override
  State<SplashScreenmain> createState() => _SplashScreenmainState();
}

class _SplashScreenmainState extends State<SplashScreenmain> {
  void load() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, Halaman_utama.routeName);
  }

  @override
  void initState() {
    load();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_siga.png",
                        width: MediaQuery.of(context).size.width * 0.20,
                      ),
                      Container(
                        width: 20,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        width: MediaQuery.of(context).size.width * 0.20,
                      )
                    ],
                  ),
                  Container(
                    height: 20,
                  ),
                  Text(
                    "SIGA KOTA BAUBAU",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Sistim Informasi Gender Dan Anak Kota Bauba",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  Text(
                    "Dinas Pemberdayaan Perempuan dan Perlindungan Anak",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "Kota Baubau, Sulawesi Tenggara",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
