import 'dart:convert';

import 'package:siga2/Admin_siga/Api_admin/admSetTokenLogin.dart';
import 'package:siga2/Admin_siga/Dashbord.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/spashscreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String status = "";

  _cek() async {
    await SharedPref().getData(token_login).then((value) async {
      if (await value == "null" || await value == "" || await value == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return Login();
        })));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) {
          return Dashboard();
        })));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement ini
    _cek();
    // tState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              "assets/images/logo_siga2.png",
              width: MediaQuery.of(context).size.width * 0.70,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 25, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Dinas Pemberadayaan dan Perlindungan Perempuan Dan Anak',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
                ),
                Text(
                  'Kota Baubau, Sulawesi Tenggara',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
