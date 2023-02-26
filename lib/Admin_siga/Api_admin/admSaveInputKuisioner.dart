import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> adminSaveInputKuisioner(
  String id_instansi,
  String id_data_terpilah,
  String id_indikator_kuisioner,
  String id_tahun,
  String laki_laki,
  String perempuan,
  String header,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/save_input_kuisioner"));

  Map<String, dynamic> body = {
    "id_instansi": base64_genarete(id_instansi, 4),
    "id_data_terpilah": base64_genarete(id_data_terpilah, 4),
    "id_indikator_kuisioner": base64_genarete(id_indikator_kuisioner, 4),
    "id_tahun": base64_genarete(id_tahun, 4),
    "laki_laki": base64_genarete(laki_laki, 4),
    "perempuan": base64_genarete(perempuan, 4)
  };
  try {
    var respon = await http.post(
      uri,
      body: body,
      headers: {"Authorization": header},
    );
    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print("EXEDPTION ${e}");
  } on Error catch (e) {
    print("EXEDPTION ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  }

  return "no_internet";
}
