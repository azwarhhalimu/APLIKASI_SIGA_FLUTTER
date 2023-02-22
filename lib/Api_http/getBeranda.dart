import 'dart:async';
import 'dart:io';

import 'package:siga2/Config.dart';
import "package:http/http.dart" as http;

Future<String> getBeranda() async {
  Uri uri = Uri.parse(baseUrl("api_web/beranda"));
  String pesan = "";
  try {
    var respon = await http.post(uri);

    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    pesan = 'Timeout Error: $e';
    print('Timeout Error: $e');
  } on SocketException catch (e) {
    pesan = 'Socket Error: $e';
    print('Socket Error: $e');
  } on Error catch (e) {
    pesan = 'General Error: $e';
    print('General Error: $e');
  } on AsyncError catch (e) {
    print("AsyncError: {e}");
  }

  return "no_internet";
}
