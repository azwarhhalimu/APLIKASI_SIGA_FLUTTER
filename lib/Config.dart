import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart' as crypto;
import 'package:siga2/Componen/Rc4.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:encrypt/encrypt.dart';

String domain = "http://localhost:2000/";
String baseUrl(String url) {
  return domain + url;
}
// String domain = "https://dp3a.baubaukota.go.id/";
// String baseUrl(String url) {
//   return domain + "index.php/" + url;
// }

String VERSI = "1.0.0";
String FLUTTER_VERSI = "3.7.5";

String nama_aplikasi = "Dinas Pemberdayaan Perempuan dan Perlindungan Anak";

String getIdYoutube(String url) {
  return url.replaceAll(
      "https://dp3akotabaubau.com/index.php/images/youtube_image?f=", "");
}

String encmd5(String input) {
  List<int> inputBytes = utf8.encode(input);

  // Generate the MD5 hash

  var md5 = crypto.md5;
  crypto.Digest md5Digest = md5.convert(inputBytes);

  // Convert the digest to a hexadecimal string
  String md5Hash = md5Digest.toString();

  // Print the MD5 hash to the console
  return md5Hash;
}

String encryptMD5(String text, int pengacakan) {
  String digest = text;
  var md5 = crypto.md5;
  for (int i = 0; i < pengacakan; i++) {
    digest = md5.convert(utf8.encode(digest)).toString();
  }
  return digest;
}

String random() {
  int min = 10000;
  int max = 99999;
  Random r = new Random();
  int hasil = (min + r.nextInt(max - min));

  return hasil.toString();
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(em);
}

String decodeBase64(String data) {
  List<int> decodedBytes = base64.decode(data); // Melakukan decoding
  String decodedString =
      utf8.decode(decodedBytes); // Mengubah byte menjadi string
  return decodedString;
}

String hapusSparasiLoginData(String data) {
  List hasil = data.split("****");
  return hasil[0];
}

Future<String> getTimeServer() async {
  Uri uri = Uri.parse(baseUrl("auth/gtz"));
  var respon = await http.get(uri).timeout(Duration(seconds: 5));
  if (respon.statusCode == 200) {
    String hasil = jsonDecode(respon.body)["hasil"];
    for (int i = 0; i < 5; i++) {
      hasil = utf8.decode(base64.decode(hasil));
    }

    return hasil;
  }

  return DateFormat("yy-MM-dd HH:mm:ss").format(DateTime.now());
}

String kunci(String text) {
  List a = [
    "A",
  ];
  List b = [
    "z",
  ];
  String x = text;
  for (int i = 0; i < a.length; i++) {
    x = x.replaceAll(a[i], b[i]);
  }
  return x;
}

base64_genarete(String input, int opsi) {
  String hasil = input;
  for (int i = 0; i < opsi; i++) {
    hasil = base64.encode(utf8.encode(hasil));
  }

  hasil = (hasil);

  return hasil;
}

Future<String> generateTokenLoged() async {
  // model token
  // username.token.time_server
  var data = await SharedPref().getData("login_data");
  var getToken = await SharedPref().getData("token_login");
  Map getData = jsonDecode(data);
  String timeserver = "";
  await getTimeServer().then((value) async {
    timeserver = await value;
  });
  String token = getData["username"] + "." + getToken + "." + timeserver;

  return token;
}

encryptRc(String data) {
  String key = "348290jjjifud83409q";
  String encrypt = RC4.encrypt(key, data);
  return encrypt;
}
