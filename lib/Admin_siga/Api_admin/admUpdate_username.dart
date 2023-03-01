import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<String> updateUsername(String data, String header) async {
  Uri uri = Uri.parse(baseUrl("api_siga_admin/update_username"));
  try {
    var respon = await http.post(uri, headers: {
      "Authorization": header,
    }, body: {
      "data": data
    });

    print(respon.body);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  }
  return "no_internet";
}
