import 'dart:convert';

import 'package:siga2/Admin_siga/Api_admin/admLogin.dart';
import 'package:siga2/Admin_siga/Dashbord.dart';
import 'package:siga2/Admin_siga/enviroment.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  static String routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var globaKey = GlobalKey<FormState>();
  String username = "";
  String password = "";
  void _login() async {
    if (globaKey.currentState!.validate()) {
      Loading_dialog(title: "Sedang login...", context: context).show();
      admLogin(username, password).then((value) async {
        print(value);
        Navigator.pop(context);

        if (value == "terjadi_masalah") {
          Alert(context, "OPpzzz", "Terjadi masalah pada internal server");
        } else if (value == "no_internet") {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return No_internet(click: _login);
              }));
        } else {
          String status = jsonDecode(value)["status"];

          if (status == "login_sukses") {
            //data login di potong 20 angka dari encode
            String data_loginx = (jsonDecode(value)["data"]).substring(10);
            data_loginx = utf8.decode(base64.decode(data_loginx));
            Map<String, dynamic> getUser = jsonDecode(data_loginx);
            print(data_loginx);

            //data ydaang di get yaitu
            //  - token
            //  - id_instansi
            //  - nama_instanasi
            //  - username
            //  - alamat

            Map<String, String> data_login = {};
            data_login.addAll({
              "token": hapusSparasiLoginData(getUser["token"]),
              "id_instansi": hapusSparasiLoginData(getUser["id_instansi"]),
              "nama_instansi": hapusSparasiLoginData(getUser["nama_instansi"]),
              "username": hapusSparasiLoginData(getUser["username"]),
              "alamat": hapusSparasiLoginData(getUser["alamat"]),
            });

            SharedPref().setData(token_login, jsonEncode(data_login));

            Alert(context, "Sukses", "Login Berhasil").then((value) {
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: ((context) {
                return Dashboard();
              })));
            });
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: ((context) {
            //   return Dashboard();
            // })));
          } else if (status == "login_gagal") {
            Alert(context, "Gagal", "Username atau password tidak benar");
          } else if (status == "auth_gagal") {
            Alert(context, "Autenfitikasi", "Protokol login tidak benar");
          } else {}
        }
      });
    }
  }

  bool _obsecured = true;

  @override
  Widget build(BuildContext context) {
    double keyVisbiliti = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo_siga2.png",
                  width: MediaQuery.of(context).size.width * 0.5,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Silahkan login untuk melanjutkan",
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                    key: globaKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == "") return "Tidak boleh kosong";
                          },
                          onChanged: ((value) {
                            username = value;
                          }),
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Username",
                              border: OutlineInputBorder(),
                              label: Text("Masukkan username anda")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _obsecured,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: ((value) {
                            password = value;
                          }),
                          validator: (value) {
                            if (value == "") return "Tidak boleh kosong";
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.password),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obsecured = !_obsecured;
                                  });
                                },
                                child: Icon(!_obsecured
                                    ? Icons.visibility_off_rounded
                                    : Icons.visibility),
                              ),
                              hintText: "Ketikkan password anda",
                              border: OutlineInputBorder(),
                              label: Text("Password")),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                _login();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Login"),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Jika anda belum memiliki username dan password, silahkan untuk menguhubungi " +
                              nama_aplikasi,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(123, 0, 0, 0)),
                        )
                      ],
                    )),
              ],
            ),
          ),
          keyVisbiliti > 0
              ? Container()
              : Positioned(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: SvgPicture.asset(
                      "assets/images/bg2.svg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  bottom: 0,
                ),
          keyVisbiliti > 0
              ? Container()
              : Positioned(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "DINAS PEMBERDAYAAN DAN PERLINDUNGAN ANAK DAN PEREMPUAN ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                        Text(
                          "Kota Baubau, Sulawesi Tenggara",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  bottom: 5,
                ),
          Positioned(
              top: 35,
              right: 15,
              child: TextButton.icon(
                icon: Icon(Icons.close),
                label: Text("Keluar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))
        ],
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
