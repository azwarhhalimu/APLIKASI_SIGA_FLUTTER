import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admUpdate_password.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Componen/SharedPref.dart';

class Ubah_password extends StatefulWidget {
  const Ubah_password({super.key});

  @override
  State<Ubah_password> createState() => _Ubah_passwordState();
}

class _Ubah_passwordState extends State<Ubah_password> {
  String password_baru = "";
  String password_lama = "";
  var _keyForm = GlobalKey<FormState>();
  void _updatePassword() async {
    if (_keyForm.currentState!.validate()) {
      Loading_dialog(title: "Mengudate password...", context: context);
      var auth = new Autentifikasi();
      await auth.getTime(context, null);
      String header = await auth.createHeaderToken();
      updatePassword(header, password_baru, password_lama).then((value) async {
        Navigator.pop(context);
        if (value == "terjadi_masalah") {
          Alert(context, "Terjadi masalah", "Internel server error");
        } else if (value == "no_internet") {
          Alert(context, "No Intenet", "Periksa kembali koneksi internet anda")
              .then((value) {
            _updatePassword();
          });
        } else {
          String status = jsonDecode(value)["status"];
          if (status == "password_salah") {
            Alert(context, "Error",
                "Password lama yang anda masukkan tidak benar");
          } else if (status == "password_update") {
            SharedPref().remove(await Enviroment.getToken());
            Alert(context, "Sukses",
                    "Password berhasil di ganti. Silahkan login kembali")
                .then((value) {
              Navigator.pushNamed(context, Login.routeName);
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Ganti Password",
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              TextFormField(
                onChanged: (value) {
                  password_baru = value;
                },
                validator: (value) {
                  if (value == "") {
                    return "Tidak boleh kosong";
                  } else if (value.toString().length < 6) {
                    return "Password anda terlalu pendek";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Password Baru"),
                  hintText: "Ketikkan password baru anda...",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: (value) {
                  password_lama = value;
                },
                validator: (value) {
                  if (value == "") {
                    return "Tidak boleh kosong";
                  }
                },
                decoration: InputDecoration(
                  label: Text("Password Anda Saat anda"),
                  hintText: "Ketikkan password saat ini...",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _updatePassword();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Update Password"),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
