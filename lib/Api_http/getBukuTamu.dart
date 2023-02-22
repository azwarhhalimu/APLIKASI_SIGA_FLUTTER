import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getBukuTamu() async {
  Uri uri = Uri.parse(baseUrl("api_web/get_buku_tamu"));
  try {
    var respon = await http.post(uri);

    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print("Exeption ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on HandleUncaughtErrorHandler catch (e) {
    print("HandleUncaughtErrorHandler ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  }
  return "no_internet";
}
