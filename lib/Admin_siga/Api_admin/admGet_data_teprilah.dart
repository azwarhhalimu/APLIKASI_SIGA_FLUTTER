import 'dart:async';

import 'package:siga2/Config.dart';

import 'package:http/http.dart' as http;

Future<String> admGetDataTerpilah(String id_instansi, String header) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_data_terpilah"));

  try {
    var respon = await http.post(
      uri,
      body: {"id_instansi": await base64_genarete(id_instansi, 2)},
      headers: {"Authorization": header},
    );

    if (respon.statusCode == 200) {
      return respon.body;
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
