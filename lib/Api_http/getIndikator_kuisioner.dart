import 'dart:async';
import 'dart:io';

import 'package:siga2/Config.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String> getIndikatoriKuisioner(
    String id_instansi, String id_data_terpilah, String id_tahun) async {
  Uri uri = Uri.parse(baseUrl("api_web/get_indikator_kuisioner"));
  try {
    var respon = await http.post(uri, body: {
      "id_instansi": id_instansi,
      "id_data_terpilah": id_data_terpilah,
      "id_tahun": id_tahun,
    });
    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print('exeption ${e}');
  } on Error catch (e) {
    print('error ${e}');
  } on SocketException catch (e) {
    print('socekt exption ${e}');
  } on HandleUncaughtErrorHandler catch (e) {
    print('error ${e}');
  }
  return "no_internet";
}
