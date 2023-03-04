import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getSemuaBerita() async {
  Uri uri = Uri.parse(baseUrl("api_web/semua_berita"));
  try {
    var respon = await http.post(uri);
    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  }
  return "no_internet";
}
