import "package:http/http.dart" as http;
import 'package:siga2/Config.dart';

Future<String> getTimeZone() async {
  Uri uri = Uri.parse(baseUrl("auth/gtz"));
  var respon = await http.post(uri);
  if (respon.statusCode == 200) {
    return respon.body;
  }
  return "terjadi_masalah";
}
