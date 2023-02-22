import 'dart:io';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getLihatVideo(String id_video) async {
  Uri uri = Uri.parse(baseUrl("api_web/lihat_video?id_video=${id_video}"));
  try {
    var respon = await http.post(uri);
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
