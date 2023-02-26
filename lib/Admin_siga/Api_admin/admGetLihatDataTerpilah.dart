import 'package:siga2/Config.dart';

import 'package:http/http.dart' as http;

Future<String> admGetLihatDataTerpilah(
    bool semua_tahun,
    String id_instansi,
    String tahun,
    String id_tahun,
    String id_data_terpilah,
    String header) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/Lihat_indikator"));
  var respon = await http.post(uri, headers: {
    "Authorization": header,
  }, body: {
    "id_instansi": base64_genarete(id_instansi, 4),
    "id_data_terpilah": base64_genarete(id_data_terpilah, 4),
    "id_tahun": base64_genarete(id_tahun, 4),
    "tahun": base64_genarete(tahun, 4),
    "semua_tahun": semua_tahun ? "true" : "false"
  });
  print(respon.body);
  if (respon.statusCode == 200) {
    return respon.body;
  }
  return "terjadi_masalah";
}
