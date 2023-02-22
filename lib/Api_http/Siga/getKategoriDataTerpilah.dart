import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getKategoriDataTerpilah() async {
  Uri uri = Uri.parse(baseUrl("api_siga/kategori_data_terpilah"));
  try {
    var respon = await http.post(uri);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  }
  return "no_internet";
}
