import 'dart:io';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getGaler() async {
  Uri uri = Uri.parse(baseUrl("api/galeri.json"));
  try {
    var respon = await http.get(uri);
    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on Exception catch (e) {
    print("Exception ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  } on SocketException catch (e) {
    print("SocketException ${e}");
  }
  return "no_internet";
}
