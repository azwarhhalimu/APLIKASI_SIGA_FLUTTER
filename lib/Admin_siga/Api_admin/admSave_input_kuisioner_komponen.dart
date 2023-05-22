import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:siga2/Config.dart';

Future<String> admSave_input_kuisioner_komponen(
  String header,
  String data,
  String id_indikator_kuisioner,
  String id_tahun,
  String id_data_terpilah,
  String id_instansi,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/save_indikator_komponen_nilai"));

  try {
    var respon = await http.post(
      uri,
      body: {
        'id_instansi': id_instansi,
        "data": data,
        "id_tahun": id_tahun,
        "id_data_terpilah": id_data_terpilah,
        "id_indikator_kuisioner": id_indikator_kuisioner
      },
      headers: {"Authorization": header},
    );
    print(respon.body);

    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    return "Time Exption";
  } on Exception catch (e) {
    return "Exeption";
  } on Error catch (e) {
    return "Error";
  }
}
