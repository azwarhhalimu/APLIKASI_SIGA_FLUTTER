import 'dart:async';
import 'dart:io';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getSemuaInstansi() async {
  Uri uri = Uri.parse(baseUrl("api_web/semua_instansi"));

  try {
    var respon = await http.post(uri).timeout(Duration(seconds: 5));
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("T e" + e.toString());
  } on SocketException catch (e) {
    print("So" + e.toString());
  } on Error catch (e) {
    print("error " + e.toString());
  } on HandleUncaughtErrorHandler catch (e) {
    print("34");
  } on AsyncError catch (e) {
    print("error " + e.toString());
  }

  return "no_internet";
}
