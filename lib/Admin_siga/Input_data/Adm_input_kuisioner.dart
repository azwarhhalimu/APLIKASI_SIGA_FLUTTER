import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admSaveInputKuisioner.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';

class Adm_input_kuisioner extends StatefulWidget {
  String data_terpilah;
  String indikator_kuisioner;

  String id_data_terpilah;
  String id_indikator_kuisioner;
  String id_tahun;
  String tahun;

  Adm_input_kuisioner({
    super.key,
    required this.data_terpilah,
    required this.indikator_kuisioner,
    required this.id_data_terpilah,
    required this.id_indikator_kuisioner,
    required this.id_tahun,
    required this.tahun,
  });

  @override
  State<Adm_input_kuisioner> createState() => _Adm_input_kuisionerState();
}

class _Adm_input_kuisionerState extends State<Adm_input_kuisioner> {
  var _formKey = GlobalKey<FormState>();
  String laki_laki = "0";
  String perempuan = "0";

  _simpan() async {
    if (_formKey.currentState!.validate()) {
      Loading_dialog(title: "Menyimpan data", context: context).show();
      var auth = Autentifikasi();
      var c = await auth.getTime(context, num);
      Map<String, dynamic> dataLogin = await auth.getLoginData();
      String header = await auth.createHeaderToken();

      adminSaveInputKuisioner(
        dataLogin["id_instansi"],
        widget.id_data_terpilah,
        widget.id_indikator_kuisioner,
        widget.id_tahun,
        laki_laki,
        perempuan,
        header,
      ).then((value) {
        Navigator.pop(context);
        if (value == "terjadi_masalah") {
          Alert(context, "Oppzz", "Terjadi masalah");
        } else if (value == "no_internet") {
          Alert(context, "No Internet", "Periksan sambungan internet anda");
        } else {
          String status = jsonDecode(value)["status"];
          if (status == "update" || status == "saved") {
            Alert(context, "Sukses", "Data berhasil di simpan").then((value) {
              Navigator.pop(context, "refresh");
            });
          } else {
            Alert(context, "Token Expired", "Silahkan login kembali")
                .then((value) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      height: MediaQuery.of(context).size.height * 0.80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data_terpilah,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.indikator_kuisioner,
            style: TextStyle(color: Colors.black54),
          ),
          Text(
            "Tahun " + widget.tahun,
            style: TextStyle(color: Colors.black54),
          ),
          Divider(),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Laki-laki"),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == 0 || value == "") {
                                  return "Wajib di isi";
                                }
                              },
                              onChanged: (value) => laki_laki = value,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(9, 0, 0, 0),
                                hintText: "0",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("perempuan"),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value == 0 || value == "") {
                                  return "Wajib di isi";
                                }
                              },
                              onChanged: (value) => perempuan = value,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(9, 0, 0, 0),
                                hintText: "0",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  _simpan();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Simpan Data"),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(202, 244, 67, 54)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Batal"),
                )),
          ),
        ],
      ),
    );
  }
}
