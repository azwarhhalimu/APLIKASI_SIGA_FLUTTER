import 'dart:convert';

import 'package:siga2/Api_http/getSemuaTahunIndikatorKuisioner.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Shimmer/Shimmer_lihat_semua_tahun.dart';
import 'package:flutter/material.dart';

class Semua_tahun_indikator_kuisioner extends StatefulWidget {
  String id_instansi;
  String id_data_terpilah;
  String data_terpilah;
  String label_table;
  Semua_tahun_indikator_kuisioner({
    super.key,
    required this.id_instansi,
    required this.id_data_terpilah,
    required this.data_terpilah,
    required this.label_table,
  });

  @override
  State<Semua_tahun_indikator_kuisioner> createState() =>
      _Semua_tahun_indikator_kuisionerState();
}

class _Semua_tahun_indikator_kuisionerState
    extends State<Semua_tahun_indikator_kuisioner> {
  List data = [];
  _getData() {
    setState(() {
      isLoading = true;
    });
    getSemuaTahunIndikator(widget.id_instansi, widget.id_data_terpilah)
        .then((value) {
      setState(() {
        isLoading = false;
      });
      print(value);
      if (value == "terjadi_masalah") {
        Alert(context, "Ops", "Terjadi masalah pada server internal");
      } else if (value == "no_internet") {
        Alert(context, "Opps", "Periksa koneksi internet anda").then((value) {
          _getData();
        });
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Semua Data",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
        ),
      ),
      body: isLoading
          ? Shimmer_lihat_semua_tahun()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data_terpilah,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Label Data : " + widget.label_table),
                      SizedBox(
                        height: 20,
                      ),
                      for (int i = 0; i < data.length; i++)
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(33, 247, 65, 65),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[i]["indikator_kuisioner"],
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                for (int y = 0;
                                    y < data[i]["tahun"].length;
                                    y++)
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child:
                                            Text(data[i]["tahun"][y]["tahun"]),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text("Laki-laki : " +
                                            data[i]["tahun"][y]["laki_laki"]),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text("Perempuan : " +
                                            data[i]["tahun"][y]["perempuan"]),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
