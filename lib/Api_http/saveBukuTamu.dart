import 'dart:async';

import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

Future<String> saveButkuTamu(
  String nama,
  String email,
  String pesan,
) async {
  Uri uri = Uri.parse(baseUrl("api_web/save_buku_tamu"));

  String token = await SharedPref().getData("token");
  String cookie = await SharedPref().getData("cookie");

//generate

  String hasil = "";
  Future<String> setMd5(String input) async {
    String c = "";
    var md5 = crypto.md5;
    for (int i = 0; i < 5; i++) {
      c = md5.convert(utf8.encode(input)).toString();
    }
    return c;
  }

  Map<String, String> header = {
    "Authorization": "Token " + token + "." + await setMd5(token),
  };

  try {
    var respon = await http.post(uri,
        body: {"nama": nama, "pesan": pesan, "email": email}, headers: header);

    print(respon.body);

    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terajdi_masalah";
  } on Exception catch (e) {
    print("exeption ${e}");
  } on Error catch (e) {
    print("error ${e}");
  } on TimeoutException catch (e) {
    print("timeout ${e}");
  } on HandleUncaughtErrorHandler catch (e) {
    print("HandleUncaughtErrorHandler ${e}");
  }
  return "no_internet";
}
