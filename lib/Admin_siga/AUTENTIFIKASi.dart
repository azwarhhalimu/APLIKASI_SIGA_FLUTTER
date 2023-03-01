// yang di kopi
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Encryption.dart';

class Autentifikasi {
  Future<dynamic> getTime(BuildContext context, dynamic call_back) async {
    int percobaan_login = 0;
    await getTimeZone().then((value) async {
      if (value == "no_internet") {
        Alert(context, "oppzz", "No Internet").then((value) {
          getTime(context, call_back);
        });
      } else if (value == "terjadi_masalah") {
        Alert(context, "Opzz..", "Terjadi masalah");
      } else if (value == "no_internet") {
        print("[get tmz no internet]");
        getTime(context, call_back);
      } else {
        await SharedPref().setData("time_zone", value);
        print("TZ SUKSES");
        //sukses

        //callback kopi
      }
    });
  }

  Future<dynamic> createHeaderToken() async {
    String getToken = await SharedPref().getData(await Enviroment.getToken());
    String timezone = await SharedPref().getData("time_zone");

    Map<String, dynamic> token = await jsonDecode(getToken);
    String set_token =
        token["username"] + "." + token["token"] + "." + timezone;
    set_token = "Bearer " +
        Encryption.instance.encrypt(await base64_genarete(set_token, 8));
    return set_token;
    ;
  }

  Future<dynamic> getLoginData() async {
    Map<String, dynamic> data_login = await jsonDecode(
        await SharedPref().getData(await Enviroment.getToken()));
    return data_login;
  }
}
