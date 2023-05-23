import 'dart:convert';

import 'package:siga2/Api_http/Siga/getDataTerpilah_kategori.dart';
import 'package:siga2/Api_http/getDataTerpilah.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Indikator_kuisioner.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Pilih_tahun.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:flutter/material.dart';

class Data_terpilah extends StatefulWidget {
  String id_kategori_data_terpilah;
  String kategori_data_terpilah;
  Data_terpilah({
    super.key,
    required this.id_kategori_data_terpilah,
    required this.kategori_data_terpilah,
  });

  @override
  State<Data_terpilah> createState() => _Data_terpilahState();
}

class _Data_terpilahState extends State<Data_terpilah> {
  List data = [];
  _getData() {
    setState(() {
      isLoading = true;
    });
    getDataTerpilah_kategori(widget.id_kategori_data_terpilah).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "terjadi_masalah") {
        Alert(context, "Oppsz", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) => No_internet(click: _getData)));
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  @override
  void initState() {
    isSearch = false;
    _getData();
    // TODO: implement initState
    super.initState();
  }

  String pId_data_terpilah = "";
  String pId_instansi = "";
  String pLabel_tabel = "";
  String pData_terpilah = "";

  void setTahun(String id_tahun, String tahun) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return Indikator_kuisioner(
        id_data_terpilah: pId_data_terpilah,
        id_instansi: pId_instansi,
        data_terpilah: pData_terpilah,
        id_tahun: id_tahun,
        label_table: pLabel_tabel,
        tahun: tahun,
      );
    })));
  }

  _pilihTahun() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Pilih_tahun(callBack: setTahun);
        }));
  }

  String cari = "";

  bool isSearch = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = isSearch ? false : true;
                });
              },
              icon: Icon(isSearch ? Icons.close : Icons.search))
        ],
        title: !isSearch
            ? Text(
                widget.kategori_data_terpilah,
                style: TextStyle(fontSize: 13),
              )
            : TextFormField(
                onChanged: (value) {
                  setState(() {
                    cari = value.toLowerCase();
                  });
                },
                autofocus: true,
                cursorColor: Colors.white,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    focusedBorder: null,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(2),
                    hintText: "Masukkan pencarian",
                    focusColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.white)),
              ),
      ),
      body: isLoading
          ? Shimmer_data_terpilah()
          : SingleChildScrollView(
              child: Column(children: [
                for (int i = 0; i < data.length; i++)
                  data[i]["data_terpilah"]
                          .toString()
                          .toLowerCase()
                          .contains(cari)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text("${i + 1}"),
                            ),
                            title: Container(
                              decoration: BoxDecoration(
                                  color: i % 2 == 0
                                      ? Color.fromARGB(99, 252, 197, 149)
                                      : Color.fromARGB(98, 159, 149, 252),
                                  borderRadius: BorderRadius.circular(6)),
                              padding: EdgeInsets.all(5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[i]["data_terpilah"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  Text(
                                    "Sumber Data : " + data[i]["label_tabel"],
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black26),
                                  ),
                                ],
                              ),
                            ),
                            trailing: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  pLabel_tabel = data[i]["label_tabel"];
                                  pData_terpilah = data[i]["data_terpilah"];
                                  pId_instansi = data[i]["id_instansi"];
                                  pId_data_terpilah =
                                      data[i]['id_data_terpilah'];
                                  _pilihTahun();
                                },
                                icon: Icon(Icons.chevron_right_sharp)),
                          ),
                        )
                      : Container()
              ]),
            ),
    );
  }
}
