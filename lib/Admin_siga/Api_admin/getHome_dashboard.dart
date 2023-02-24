import 'dart:async';
import 'dart:convert';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:http/http.dart' as http;
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';

Future<String> getHomeDashboard(
  String username,
  String token,
  String id_instansi,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_home_dashboard"));
  var time = await SharedPref().getData("time_zone");

  String header =
      base64_genarete(username + "." + token + "." + time.toString(), 8);

  id_instansi = base64_genarete(id_instansi, 2);
  var respon = await http.post(uri,
      headers: {"Authorization": "Bearer " + header},
      body: {"id_instansi": id_instansi});
  if (respon.statusCode == 200) {
    return respon.body;
  }

  return "terjadi_masalah";
}
