import 'dart:convert';

import 'package:siga2/Api_http/getToken.dart';
import 'package:siga2/Api_http/saveBukuTamu.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:flutter/material.dart';

class Buku_tamu_baru extends StatefulWidget {
  const Buku_tamu_baru({super.key});

  @override
  State<Buku_tamu_baru> createState() => _Buku_tamu_baruState();
}

class _Buku_tamu_baruState extends State<Buku_tamu_baru> {
  String nama = "";
  String email = "";
  String pesan = "";

  test() {
    print("mantap");
  }

  var _formKey = GlobalKey<FormState>();
  _simpan() {
    if (_formKey.currentState!.validate()) {
      Loading_dialog(title: "Menyimpan data...", context: context).show();
      saveButkuTamu(nama, email, pesan).then((value) {
        //  print(value);
        Navigator.pop(context);
        if (value == "terjadi_masalah") {
          Alert(context, "Oppsss", "Internal server error");
        } else if (value == "no_internet") {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return No_internet(
                  click: _getToken(),
                );
              }));
        } else {
          String status = jsonDecode(value)["status"];
          if (status == "buku_tamu_saved") {
            Alert(context, "Sukses", "Buku tamu berhasil di simpan")
                .then((value) {
              Navigator.pop(context, "refresh");
            });
          } else {
            Alert(context, "Sukses", "Buku tamu gagal di simpan");
          }
        }
      });
    }
  }

  _getToken() {
    setState(() {
      isLoading = true;
    });
    getToken().then((value) async {
      setState(() {
        isLoading = false;
      });

      if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return No_internet(click: _getToken);
            });
      } else if (value == "terjadi_masalah") {
        Alert(context, "Oppsss", "Masalah internal server");
      } else {
        String hasil = jsonDecode(value)["token"];

        SharedPref().setData("token", hasil);
        String get = await SharedPref().getData("token");
      }
    });
  }

  bool isLoading = false;
  @override
  void initState() {
    _getToken();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Pesan Baru",
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: isLoading
          ? Center(
              child: Text("Autentifikasi..."),
            )
          : Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: [
                    Text(
                      "Harap gunakan kata-kata yang baik",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(157, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      maxLength: 30,
                      maxLines: 1,
                      onChanged: ((value) {
                        nama = value;
                      }),
                      validator: (value) {
                        if (value == "") {
                          return "Tidak boleh kosong";
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Masukkan nama anda",
                          hintMaxLines: 1,
                          label: Text("Nama")),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      onChanged: ((value) {
                        email = value;
                      }),
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 40,
                      maxLines: 1,
                      validator: (value) {
                        if (value == "") {
                          return "Email tidak boleh kosong";
                        } else {
                          if (!isEmail(value.toString())) {
                            return "Masukkan format email yang benar";
                          }
                        }
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          hintMaxLines: 1,
                          border: OutlineInputBorder(),
                          hintText: "Contoh : okos@gmail.com",
                          label: Text("Email")),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      maxLines: 4,
                      onChanged: ((value) {
                        pesan = value;
                      }),
                      maxLength: 70,
                      validator: ((value) {
                        if (value == "") {
                          return "Tidak boleh kosong";
                        }
                      }),
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "ketikkan pesan anda",
                          label: Text("Pesan")),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {
                            _simpan();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Simpan Pesan"),
                          )),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
