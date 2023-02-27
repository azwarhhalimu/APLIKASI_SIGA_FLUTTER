import 'dart:convert';

import 'package:siga2/Api_http/getDataTerpilah.dart';
import 'package:siga2/Api_http/getSemuaInstansi.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Data_terpilah.dart';
import 'package:siga2/List_item/list_item_berdasarkan_instansi.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:flutter/material.dart';

class Berasarkan_instansi extends StatefulWidget {
  const Berasarkan_instansi({super.key});

  @override
  State<Berasarkan_instansi> createState() => _Berasarkan_instansiState();
}

class _Berasarkan_instansiState extends State<Berasarkan_instansi> {
  List data = [];
  _getData() {
    setState(() {
      isLoading = true;
    });
    getSemuaInstansi().then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "terjadi_masalah") {
        Alert(context, "Oopzz", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return No_internet(click: _getData);
            }));
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  String cari = "";

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer_data_terpilah()
        : Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      "Cari",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          onChanged: (value) => setState(() {
                            cari = value;
                          }),
                          style: TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              suffixIcon: Icon(Icons.search),
                              hintText: "Masukkan pencarian anda",
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    for (int i = 0; i < data.length; i++)
                      (data[i]["nama_instansi"])
                              .toString()
                              .toLowerCase()
                              .contains(cari.toLowerCase())
                          ? List_item_berdasarkan_instansi(
                              images: data[i]["images"],
                              jumlah_data: data[i]["jumlah_data"].toString(),
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: ((context) {
                                  return Data_terpilah(
                                      id_instansi: data[i]["id_instansi"],
                                      nama_instansi: data[i]["nama_instansi"]);
                                })));
                              },
                              id_instansi: data[i]["id_instansi"],
                              index: i,
                              nama_instansi: data[i]["nama_instansi"],
                            )
                          : Container()
                  ],
                ),
              ),
            ],
          );
  }
}
