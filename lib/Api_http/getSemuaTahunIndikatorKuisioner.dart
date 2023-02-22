import 'dart:async';
import 'dart:io';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getSemuaTahunIndikator(
    String id_instansi, String id_data_terpilah) async {
  Uri uri = Uri.parse(baseUrl("api_web/get_semua_tahun_indikator_kuisioner"));
  try {
    var respon = await http.post(uri, body: {
      "id_instansi": id_instansi,
      "id_data_terpilah": id_data_terpilah
    });
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on SocketException catch (e) {
    print('SocketException : ${e}');
  } on Error catch (e) {
    print('Error : ${e}');
  } on TimeoutException catch (e) {
    print('TimeoutException : ${e}');
  }
  return "no_internet";
}
