import 'dart:async';
import 'dart:io';

import 'package:siga2/Config.dart';

import 'package:http/http.dart' as http;

Future<String> getDataTerpilah(String id_instansi) async {
  Uri uri = Uri.parse(baseUrl("api_web/get_data_terpilah"));
  try {
    var respon = await http.post(uri, body: {"id_instansi": id_instansi});
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on SocketException catch (e) {
    print("so " + e.toString());
  } on TimeoutException catch (e) {
    print("te " + e.toString());
  } on HandleUncaughtErrorHandler catch (e) {
    print("HANDLER ERROR " + e.toString());
  } on Error catch (e) {
    print("error " + e.toString());
  }
  return "no_internet";
}
