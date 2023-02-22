import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getDataTerpilah_kategori(
    String id_kateogri_data_terpilah) async {
  Uri uri = Uri.parse(baseUrl("api_siga/data_terpilah"));
  try {
    var respon = await http.post(uri,
        body: {"id_kategori_data_terpilah": id_kateogri_data_terpilah});
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print("Exception ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  }
  return "no_internet";
}
