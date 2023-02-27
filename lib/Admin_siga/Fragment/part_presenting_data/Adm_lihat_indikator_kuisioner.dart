import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admGetLihatDataTerpilah.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';

class Adm_lihat_indikator_kuisioner extends StatefulWidget {
  String id_data_terpilah;
  String id_tahun;
  String data_terpilah;
  String tahun;
  Adm_lihat_indikator_kuisioner({
    super.key,
    required this.id_data_terpilah,
    required this.id_tahun,
    required this.tahun,
    required this.data_terpilah,
  });

  @override
  State<Adm_lihat_indikator_kuisioner> createState() =>
      _Adm_lihat_indikator_kuisionerState();
}

class _Adm_lihat_indikator_kuisionerState
    extends State<Adm_lihat_indikator_kuisioner> {
  List data = [];
  @override
  void initState() {
    init();
    _getData();
    // TODO: implement initState
    super.initState();
  }

  _getData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    var auth = Autentifikasi();
    await auth.getTime(context, null);
    String header = await auth.createHeaderToken();
    Map<String, dynamic> dataLogin = (await auth.getLoginData());
    admGetLihatDataTerpilah(semua_tahun, dataLogin["id_instansi"], widget.tahun,
            widget.id_tahun, widget.id_data_terpilah, header)
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (value == "terjadi_masalah") {
        Alert(context, "Opss", "Internal server error");
      } else if (value == "no_internet") {
        Alert(context, "No Internet", "Periksa kembali koneksi internet anda")
            .then((value) {
          _getData();
        });
      } else {
        String status = jsonDecode(value)["status"];
        if (status == "data_ok") {
          if (mounted) {
            setState(() {
              data = jsonDecode(value)["data"];
            });
          }
        } else {
          Alert(context, "Invalid Token", "Token Expired").then((value) {
            Navigator.pushReplacementNamed(context, Login.routeName);
          });
        }
      }
    });
  }

  bool isLoading = false;
  bool semua_tahun = false;
  init() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lihat Data Tahun ${widget.tahun}",
          style: TextStyle(fontSize: 13),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.data_terpilah,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Shimmer_admin_home(),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (int i = 0; i < data.length; i++)
                          Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(6)),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[i]["indikator_kuisioner"],
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Divider(),
                                !semua_tahun
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                              child: Text(
                                                  data[i]["data"]["tahun"])),
                                          Expanded(
                                              child: Text(data[i]["data"]
                                                  ["laki_laki"])),
                                          Expanded(
                                              child: Text(data[i]["data"]
                                                  ["perempuan"])),
                                          Expanded(
                                            child: Text(
                                                "Total : ${data[i]["data"]["total"]}"),
                                          ),
                                        ],
                                      )
                                    : Column(children: [
                                        for (int j = 0;
                                            j < data[i]["semua_tahun"].length;
                                            j++)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  data[i]["semua_tahun"][j]
                                                      ["tahun"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(data[i]
                                                        ["semua_tahun"][j]
                                                    ["laki_laki"]),
                                              ),
                                              Expanded(
                                                child: Text(data[i]
                                                        ["semua_tahun"][j]
                                                    ["perempuan"]),
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "Total : ${data[i]["semua_tahun"][j]["total"]}"),
                                              ),
                                            ],
                                          )
                                      ])
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color.fromARGB(255, 47, 50, 51),
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Text(
                        "Option ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      )),
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              semua_tahun = semua_tahun ? false : true;
                            });
                          },
                          child: Text(semua_tahun ? "Kembali" : "Semua Tahun")),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
