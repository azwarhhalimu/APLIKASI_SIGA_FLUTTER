import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Config.dart';

Future<String> getTimeZone() async {
  Uri uri = Uri.parse(baseUrl("auth/gtz"));
  var auth = Autentifikasi();

  try {
    var respon = await http.post(uri);
    if (respon.statusCode == 200) {
      String getTime = jsonDecode(respon.body)["hasil"];
      String time = getTime;
      for (int i = 0; i < 5; i++) {
        time = utf8.decode(base64.decode(time));
      }
      return time;
    }

    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  }
  return "no_internet";
}
