import 'dart:async';
import 'dart:convert';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:http/http.dart' as http;
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Encryption.dart';

Future<String> getHomeDashboard(
  String username,
  String token,
  String id_instansi,
) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/get_home_dashboard"));

  String header = (token);

  id_instansi = base64_genarete(id_instansi, 2);

  try {
    var respon = await http.post(uri, headers: {
      "Authorization": token
    }, body: {
      "id_instansi": await Encryption.instance.encrypt(id_instansi),
    });
    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on ErrorCallbackHandler catch (e) {
    print("error ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  }

  return "no_internet";
}
