import 'dart:async';

import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<String> admSetTokenLogin() async {
  Uri uri = Uri.parse(baseUrl("auth/token_generate"));

  var uuid = Uuid();
  String uId = uuid.v1();
  String salt = "azwarganteng :";
  try {
    Map<String, String> header = {
      "Authorization": "Token " + uId + "." + encryptMD5(uId, 5),
    };
    var respon = await http.post(uri, headers: header);

    if (respon.statusCode == 200) {
      await SharedPref().setData("UUID", uId);
      return respon.body;
    }
    return "terjadi_masalah";
  } on TimeoutException catch (e) {
    print("TimeoutException ${e}");
  } on Error catch (e) {
    print("TimeoutException ${e}");
  } on Exception catch (e) {
    print("Exception ${e}");
  }
  return "no_internet";
}
