import 'dart:async';

import 'package:siga2/Config.dart';
import 'package:http/http.dart' as http;

Future<String> getVideo() async {
  Uri uri = Uri.parse(baseUrl("api_web/video"));
  try {
    var respon = await http.post(uri);
    if (respon.statusCode == 200) {
      return respon.body;
    }
    return "terjadi_kesalahan";
  } on Exception catch (e) {
    print("Exeptino ${e}");
  } on Error catch (e) {
    print("Error ${e}");
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  }

  return "no_internet";
}
