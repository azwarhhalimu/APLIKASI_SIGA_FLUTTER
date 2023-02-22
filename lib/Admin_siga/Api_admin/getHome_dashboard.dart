import 'dart:async';
import 'dart:convert';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Componen/Rc4.dart';
import 'package:siga2/Config.dart';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> getHomeDashboard(String id_instansi) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_home_dashboard"));

  getTimeZone().then((value) async {
    try {
      var respon = await http.post(uri,
          body: {"id_instansi": random() + id_instansi},
          headers: {"Authorization": "Bearer " + ""});

      if (respon.statusCode == 200) {
        return respon.body;
      }
      return "terjadi_masalah";
    } on TimeoutException catch (e) {
      print("TimeoutException ${e}");
    } on Error catch (e) {
      print("TimeoutException ${e}");
    } on Exception catch (e) {
      print("Exception ${e}");
    }
    return "no_internet";
  });
  return "terjadi_masalah";
}
