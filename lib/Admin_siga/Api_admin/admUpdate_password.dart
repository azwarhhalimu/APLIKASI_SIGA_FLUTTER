import 'dart:async';
import 'dart:convert';

import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;
import 'package:siga2/Encryption.dart';

Future<String> updatePassword(
    String header, String password_baru, String password_lama) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/update_password"));
  try {
    var auth = new Autentifikasi();
    Map<String, dynamic> dataLogin = await auth.getLoginData();
    Map<String, dynamic> map = {
      "username": dataLogin["username"],
      "password_baru": password_baru,
      "password_lama": password_lama,
    };

    var respon = await http.post(
      uri,
      body: {
        "data": Encryption.instance
            .encrypt(random() + await base64_genarete(jsonEncode(map), 4))
      },
      headers: {"Authorization": header},
    );

    if (respon.statusCode == 200) {
      return respon.body;
    }

    return "terjadi_masalah";
  } on Error catch (e) {
    print("ERror ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  }

  return "no_internet";
}
