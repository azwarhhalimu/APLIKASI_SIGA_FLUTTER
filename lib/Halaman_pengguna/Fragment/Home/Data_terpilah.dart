import 'dart:convert';

import 'package:siga2/Api_http/getDataTerpilah.dart';
import 'package:siga2/Api_http/getIndikator_kuisioner.dart';
import 'package:siga2/Api_http/getTahun.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Indikator_kuisioner.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Pilih_tahun.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:flutter/material.dart';

class Data_terpilah extends StatefulWidget {
  String id_instansi;

  String nama_instansi;
  Data_terpilah(
      {super.key, required this.id_instansi, required this.nama_instansi});

  @override
  State<Data_terpilah> createState() => _Data_terpilahState();
}

class _Data_terpilahState extends State<Data_terpilah> {
  bool loading = false;
  List data = [];

  String pilih_id_data_terpilah = "";
  String pilih_data_terpilah = "";
  String label_table = "";

  _getTahun() {}
  _getDataTerpilah() {
    setState(() {
      loading = true;
    });
    getDataTerpilah(widget.id_instansi).then((value) {
      setState(() {
        loading = false;
      });
      print(value);
      if (value == "terjadi_masalah") {
        Alert(context, "Oppss", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        Alert(context, "No Connection", "Periksa kembali koneksi anda")
            .then((value) {
          _getDataTerpilah();
        });
      } else {
        if (mounted) {
          setState(() {
            data = jsonDecode(value)["data"];
          });
        }
      }
    });
  }

  @override
  void initState() {
    _getDataTerpilah();
    // TODO: implement initState
    super.initState();
  }

  _callBack(String id_tahun, String tahun) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) {
          print("object");
          return Indikator_kuisioner(
            id_data_terpilah: pilih_id_data_terpilah,
            id_instansi: widget.id_instansi,
            data_terpilah: pilih_data_terpilah,
            id_tahun: id_tahun,
            tahun: tahun,
            label_table: label_table,
          );
        }),
      ),
    );
  }

  _pilihTahun() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Pilih_tahun(
            callBack: _callBack,
          );
        }));
  }

  String a = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        child: loading
            ? Shimmer_data_terpilah()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.nama_instansi,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  for (int i = 0; i < data.length; i++)
                    ListTile(
                      leading: Text(((i + 1).toString())),
                      title: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: (i % 2 == 0)
                                ? Color.fromARGB(86, 241, 152, 28)
                                : Color.fromARGB(44, 214, 26, 186),
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[i]["data_terpilah"],
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Label Data:" + data[i]["label_table"],
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          _pilihTahun();
                          setState(() {
                            // untuk menyimpan secara sementara data terpilah yang akan di Kirim(
                            //   ke indikatir

                            pilih_data_terpilah = data[i]["data_terpilah"];
                            pilih_id_data_terpilah =
                                data[i]["id_data_terpilah"];
                            label_table = data[i]["label_table"];
                          });
                        },
                        child: CircleAvatar(
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.black45,
                        ),
                      ),
                    )
                ],
              ),
      ),
    );
  }
}
