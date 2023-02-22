import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<String> getToken() async {
  var uuid = Uuid();
  Uri uri = Uri.parse(baseUrl("api_web/get_token"));

  String token = uuid.v4().toString();

  try {
    Map<String, String> header = {
      "Authorization": "Token " + token,
    };

    var respon = await http.post(uri, headers: header);
    String rawCookie = respon.headers['set-cookie'].toString();
    header["cookie"] = rawCookie;
    await SharedPref().setData("cookie", rawCookie);
    await SharedPref().setData("token", token);
    print("set " + rawCookie);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException : ${e}");
  } on Error catch (e) {
    print("Error : ${e}");
  } on Exception catch (e) {
    print("Error : ${e}");
  }

  return "no_internet";
}
