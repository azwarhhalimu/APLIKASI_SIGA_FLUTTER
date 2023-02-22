import 'package:siga2/Config.dart';
import "package:http/http.dart" as http;

Future<String> getTahun() async {
  Uri uri = Uri.parse(baseUrl("api_web/get_tahun"));
  var respon = await http.post(uri);

  if (respon.statusCode == 200) {
    return respon.body;
  }
  return "terjadi_masalah";
}
