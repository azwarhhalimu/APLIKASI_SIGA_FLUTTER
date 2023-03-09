import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> ApiGetVersionApp() async {
  Uri uri = Uri.parse(baseUrl("api_web/get_version_app"));
  try {
    var respon = await http.post(uri);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print("Exception ${e}");
  } on Error catch (e) {
    print("error");
  } on TimeoutException catch (e) {
    print("timeout");
  }
  return "no_internet";
}
