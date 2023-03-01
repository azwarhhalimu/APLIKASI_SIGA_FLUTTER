import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admUpdate_username.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Encryption.dart';

class Ubah_username extends StatefulWidget {
  static String rounteName = "/ubah_username";
  const Ubah_username({super.key});

  @override
  State<Ubah_username> createState() => _Ubah_usernameState();
}

class _Ubah_usernameState extends State<Ubah_username> {
  String username = "";
  String password = "";

  _init() async {
    var c = Autentifikasi();
    Map<String, dynamic> dataLogin = (await c.getLoginData());
    username = await dataLogin["username"];
    setState(() {
      cUsernmae.text = username;
    });
  }

  var cUsernmae = TextEditingController();
  var _FomrController = GlobalKey<FormState>();

  @override
  void initState() {
    _init();

    // TODO: implement initState
    super.initState();
  }

  _update() async {
    if (_FomrController.currentState!.validate()) {
      Loading_dialog(title: "Mengganti password...", context: context).show();
      var auth = Autentifikasi();
      await auth.getTime(context, _update);
      Map<String, dynamic> loginData = await auth.getLoginData();
      String header = await auth.createHeaderToken();

      var encrypt = await Encryption.instance;
      Map<String, dynamic> data_yang_dikirim = {
        "id_instansi": (loginData["id_instansi"]),
        "username_baru": (username),
        "password": (password),
        "username_lama": (loginData["username"])
      };
      String data = jsonEncode(data_yang_dikirim);
      data = random() + await encrypt.encrypt(await base64_genarete(data, 5));

      updateUsername(data, header).then((value) async {
        Navigator.pop(context); //close loading
        if (value == "no_internet") {
          Alert(context, "No Interent", "Periksa kembali koneksi internet anda")
              .then((value) {
            _update();
          });
        } else if (value == "terjadi_kesalahan") {
          Alert(context, "Eror", "Terjadi masalah pada internal server");
        } else {
          String status = jsonDecode(value)["status"];
          if (status == "token_invalid") {
            Alert(context, "INVALID TOKEN", "Silahkan login ulang")
                .then((value) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          } else if (status == "password_salah") {
            Alert(context, "Autentifikasi Gagal",
                "Password yang anda masukkan salah");
          } else if (status == "update_username_sukses") {
            String data = jsonDecode(value)["data_login"];
            data = (Encryption.instance.decrypt(data));
            await SharedPref().setData(await Enviroment.getToken(), data);
            await SharedPref().remove(await Enviroment.getToken());
            Alert(context, "Sukses",
                    "Username berhasil di update. Silahkan login ulang")
                .then((value) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          }
        }
      });
    }
  }

  bool isObSecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black87,
            )),
        backgroundColor: Colors.white,
        title: Text(
          "Ubah Username",
          style: TextStyle(color: Colors.black87, fontSize: 13),
        ),
      ),
      body: Form(
          key: _FomrController,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (value) {
                    username = value;
                  },
                  validator: (value) {
                    if (value == "") {
                      return "Tidak boleh kosong";
                    } else if (value.toString().length < 6) {
                      return "Usrname anda terlalu pendek";
                    }
                  },
                  controller: cUsernmae,
                  decoration: InputDecoration(
                    label: Text("Username"),
                    hintText: "Masukkan userneme baru",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: isObSecure,
                  validator: (value) {
                    if (value == "") {
                      return "Tidak boleh kosong";
                    } else if (value.toString().length < 6) {
                      return "password anda terlalu pendek";
                    }
                  },
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hintText: "Masukkan password anda  saat ini",
                    border: OutlineInputBorder(),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                        value: !isObSecure ? true : false,
                        onChanged: (value) {
                          setState(() {
                            isObSecure = (value == true) ? false : true;
                          });
                        }),
                    Text("Tampilkan password")
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          _update();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Update Username"),
                        )))
              ],
            ),
          )),
    );
  }
}
