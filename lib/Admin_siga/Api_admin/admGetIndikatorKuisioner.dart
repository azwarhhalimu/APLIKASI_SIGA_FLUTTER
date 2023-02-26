import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> admGetIndikatorKuisioner(
  String token,
  String id_instansi,
  String id_data_terpilah,
  String id_tahun,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_indikator_kuisioner"));
  try {
    var respon = await http.post(uri, headers: {
      "Authorization": token,
    }, body: {
      "id_instansi": await base64_genarete(id_instansi, 4),
      "id_data_terpilah": await base64_genarete(id_data_terpilah, 4),
      "id_tahun": await base64_genarete(id_tahun, 4),
    });

    print(respon.body);
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
