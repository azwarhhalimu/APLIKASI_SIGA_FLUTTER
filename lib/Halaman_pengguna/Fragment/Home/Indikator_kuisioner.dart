import 'dart:convert';

import 'package:siga2/Api_http/getIndikator_kuisioner.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Pilih_tahun.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Semua_tahun_indikator_kuisioner.dart';
import 'package:siga2/Shimmer/Shimmer_indikator_kuisioner.dart';
import 'package:flutter/material.dart';

class Indikator_kuisioner extends StatefulWidget {
  String id_data_terpilah;
  String id_instansi;
  String data_terpilah;
  String id_tahun;
  String tahun;
  String label_table;
  Indikator_kuisioner({
    super.key,
    required this.id_data_terpilah,
    required this.id_instansi,
    required this.data_terpilah,
    required this.id_tahun,
    required this.label_table,
    required this.tahun,
  });

  @override
  State<Indikator_kuisioner> createState() => _Indikator_kuisionerState();
}

class _Indikator_kuisionerState extends State<Indikator_kuisioner> {
  List data = [];
  bool isLoading = false;
  _getIndikator_kuisioner() {
    setState(() {
      isLoading = true;
    });
    getIndikatoriKuisioner(
      widget.id_instansi,
      widget.id_data_terpilah,
      widget.id_tahun,
    ).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "no_internet") {
        Alert(context, "Opps",
                "Periksa konekksi internet anda. Pastikan anda menggunakan koneksi internet yang stabil")
            .then((value) {
          _getIndikator_kuisioner();
        });
      } else if (value == "terjadi_masalah") {
        Alert(context, "Opss", "Terjadi masalah pada internal server")
            .then((value) {
          //  Navigator.pop(context);
        });
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  _callBack(String id_tahun, String tahun) {
    setState(() {
      widget.id_tahun = id_tahun;
      widget.tahun = tahun;
    });
    Navigator.pop(context);
    _getIndikator_kuisioner();
  }

  _gantiTahun() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Pilih_tahun(
            callBack: _callBack,
          );
        }));
  }

  @override
  void initState() {
    _getIndikator_kuisioner();
    // TODO: implement initState
    super.initState();
  }

  String a = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data_terpilah,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Sumber Data : " + widget.label_table,
                      style: TextStyle(color: Color.fromARGB(211, 0, 0, 0)),
                    ),
                    Text(
                      "Tahun Data : " + widget.tahun,
                      style: TextStyle(color: Color.fromARGB(211, 0, 0, 0)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    isLoading ? Shimmer_indikator_kuisioner() : Container(),
                    for (int i = 0; i < data.length; i++)
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Text((i + 1).toString()),
                              ),
                            ],
                          ),
                          title: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: (i % 2 == 0)
                                    ? Color.fromARGB(83, 255, 177, 177)
                                    : Color.fromARGB(82, 190, 177, 255),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data[i]["indikator_kuisioner"]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Laki-laki : " + data[i]["laki_laki"],
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 13),
                                    ),
                                    Text(
                                      "Perempuan : " + data[i]["perempuan"],
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        _gantiTahun();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Ganti Tahun"),
                      )),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) {
                              return Semua_tahun_indikator_kuisioner(
                                id_instansi: widget.id_instansi,
                                id_data_terpilah: widget.id_data_terpilah,
                                data_terpilah: widget.data_terpilah,
                                label_table: widget.label_table,
                              );
                            }),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Lihat Semua"),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
