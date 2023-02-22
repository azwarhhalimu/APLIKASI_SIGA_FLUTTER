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

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer_data_terpilah()
        : ListView(
            children: [
              for (int i = 0; i < data.length; i++)
                List_item_berdasarkan_instansi(
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
            ],
          );
  }
}
