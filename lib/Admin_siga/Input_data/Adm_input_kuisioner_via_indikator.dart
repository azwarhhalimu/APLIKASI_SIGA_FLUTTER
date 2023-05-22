import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admGetNilaiKomponen.dart';
import 'package:siga2/Admin_siga/Api_admin/admSave_input_kuisioner_komponen.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Config.dart';

class Adm_input_input_kuisioner_via_indikator extends StatefulWidget {
  Adm_input_input_kuisioner_via_indikator({
    super.key,
    required this.komponen_nilai,
    required this.id_tahun,
    required this.id_data_terpilah,
    required this.id_indikator_kuisioner,
  });
  List komponen_nilai = [];
  String id_tahun;
  String id_data_terpilah;
  String id_indikator_kuisioner;

  @override
  State<Adm_input_input_kuisioner_via_indikator> createState() =>
      _Adm_input_input_kuisioner_via_indikatorState();
}

class _Adm_input_input_kuisioner_via_indikatorState
    extends State<Adm_input_input_kuisioner_via_indikator> {
  var komponen_nilai = [];
  final _form = GlobalKey<FormState>();
  bool loading = false;
  void _submit() async {
    if (_form.currentState!.validate()) {
      new Loading_dialog(title: "Menyimpan...", context: context).show();
      print(jsonEncode(formBaru));
      var a = new Autentifikasi();
      a.getTime(context, null);
      String header = await a.createHeaderToken();
      Map<String, dynamic> dataLogin = await a.getLoginData();
      String id_instansi = dataLogin["id_instansi"];
      admSave_input_kuisioner_komponen(
              header,
              base64_genarete(jsonEncode(formBaru), 1),
              widget.id_indikator_kuisioner,
              widget.id_tahun,
              widget.id_data_terpilah,
              id_instansi)
          .then((value) {
        Navigator.pop(context);
        var status = jsonDecode(value);

        Alert(
                context,
                "Suseks",
                status["status"] == "data_saved"
                    ? "Data berhasil di simpan"
                    : "Data berhasil di update")
            .then((value) => Navigator.pop(context, "refresh"));
      });
      // print(formBaru);
    }
  }

  List formBaru = [];

  createStateForm() {
    setState(() {
      komponen_nilai.map((e) {
        List getSubKomponen = e["sub_komponen"];

        formBaru.add({
          "id_komponen_nilai": e["id_komponen_nilai"],
          "komponen_nilai": e["komponen_nilai"],
          'sub_komponen': getSubKomponen
              .map((c) => ({
                    "id_sub_komponen": c["id_sub_komponen"],
                    "sub_komponen_nilai": c["sub_komponen_nilai"],
                    "nilai": c["nilai"],
                  }))
              .toList()
        });
      }).toList();
    });
    loading = false;
  }

  void loadData() async {
    await _getData();
  }

  @override
  void initState() {
    print(widget.id_indikator_kuisioner);
    // TODO: implement initState
    loadData();
    super.initState();
  }

  _getData() async {
    setState(() {
      loading = true;
    });
    var a = new Autentifikasi();
    a.getTime(context, null);
    String header = await a.createHeaderToken();
    Map<String, dynamic> dataLogin = await a.getLoginData();
    String id_instansi = dataLogin["id_instansi"];
    await admGetNilaiKomponen(
      header,
      id_instansi,
      widget.id_indikator_kuisioner,
      widget.id_tahun,
      widget.id_data_terpilah,
    ).then((value) {
      List data = jsonDecode(value)["data"];
      print(value);

      komponen_nilai = data;
    });
    createStateForm();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: Colors.black87,
                )),
            backgroundColor: Colors.white,
            title: Text(
              "Input Data Komponen Nilai",
              style: TextStyle(fontSize: 12, color: Colors.black87),
            )),
        loading
            ? Expanded(
                child: Center(
                  child: Text("mengambil data..."),
                ),
              )
            : Expanded(
                child: Form(
                key: _form,
                child: ListView.builder(
                  itemCount: komponen_nilai.length,
                  itemBuilder: (context, index) {
                    var getData = komponen_nilai[index];
                    return Container(
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black12)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getData["komponen_nilai"]),
                          for (int a = 0;
                              a < getData["sub_komponen"].length;
                              a++)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 10,
                                ),
                                Text(
                                  getData["sub_komponen"][a]
                                      ["sub_komponen_nilai"],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                TextFormField(
                                  initialValue: formBaru[index]["sub_komponen"]
                                          [a]["nilai"]
                                      .toString(),
                                  onChanged: (e) {
                                    formBaru[index]["sub_komponen"][a]
                                        ["nilai"] = e == "" ? 0 : e;
                                    print(formBaru);
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Tidak boleh kosong";
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    // for below version 2 use this
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
// for version 2 and greater youcan also use this
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                      hintText: "Masukkan jumlah",
                                      border: OutlineInputBorder()),
                                ),
                              ],
                            )
                        ],
                      ),
                    );
                  },
                ),
              )),
        loading
            ? Container()
            : Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _submit();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Simpan Data",
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
