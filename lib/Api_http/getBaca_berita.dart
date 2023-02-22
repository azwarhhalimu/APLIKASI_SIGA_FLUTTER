import 'package:siga2/Config.dart';

import 'package:http/http.dart' as http;

Future<String> getBacaBerita(String id_berita) async {
  Uri uri = Uri.parse(baseUrl("api_web/lihat_berita"));
  var respon = await http.post(uri, body: {"id_berita": id_berita});
  if (respon.statusCode == 200) {
    return respon.body;
  }

  return "terjadi_masalah";
}
