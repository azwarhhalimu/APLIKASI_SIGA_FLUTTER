import 'dart:async';

import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import "package:http/http.dart" as http;
import 'package:uuid/uuid.dart';

Future<String> admLogin(String username, String password) async {
  Uri uri = Uri.parse(baseUrl("auth/login"));

  var uuid = Uuid().v1();
  try {
    var respon = await http.post(
      uri,
      body: {
        "username": username,
        "password": password,
      },
    ).timeout(Duration(seconds: 5));

    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_kesalahan";
  } on Error catch (e) {
    print("ERror ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  }

  return "no_internet";
}
