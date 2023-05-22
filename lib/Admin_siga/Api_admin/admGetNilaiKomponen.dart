import 'package:http/http.dart' as http;
import 'package:siga2/Config.dart';

Future<String> admGetNilaiKomponen(
  String header,
  String id_instansi,
  String id_indikator_kuisioner,
  String id_tahun,
  String id_data_terpilah,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_nilai_komponen"));
  var respon = await http.post(uri, body: {
    'id_instansi': id_instansi,
    'id_indikator_kuisioner': id_indikator_kuisioner,
    "id_tahun": id_tahun,
    "id_data_terpilah": id_data_terpilah,
  }, headers: {
    "Authorization": header
  });

  print(respon.body);
  if (respon.statusCode == 200) {
    return respon.body;
  }
  return "";
}
