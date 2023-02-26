// yang di kopi
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';

class Autentifikasi {
  Future<dynamic> getTime(BuildContext context, dynamic call_back) async {
    int percobaan_login = 0;
    await getTimeZone().then((value) async {
      if (value == "no_internet") {
        if (percobaan_login > 3) {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return No_internet(click: call_back);
              }));
        } else {
          percobaan_login = 0;
        }
        percobaan_login++;
      } else if (value == "terjadi_masalah") {
        Alert(context, "Opzz..", "Terjadi masalah");
      } else {
        await SharedPref().setData("time_zone", value);
        print("Auth sukses");
        //sukses

        //callback kopi
      }
    });
  }

  Future<dynamic> createHeaderToken() async {
    String getToken = await SharedPref().getData(Enviroment.getToken());
    String timezone = await SharedPref().getData("time_zone");

    Map<String, dynamic> token = await jsonDecode(getToken);
    String set_token =
        token["username"] + "." + token["token"] + "." + timezone;
    set_token = "Bearer " + await base64_genarete(set_token, 8);
    return set_token;
    ;
  }

  Future<dynamic> getLoginData() async {
    Map<String, dynamic> data_login =
        jsonDecode(await SharedPref().getData(Enviroment.getToken()));
    return data_login;
  }
}
