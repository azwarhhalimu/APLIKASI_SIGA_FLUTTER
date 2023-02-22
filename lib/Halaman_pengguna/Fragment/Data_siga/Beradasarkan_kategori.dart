import 'dart:convert';

import 'package:siga2/Api_http/Siga/getKategoriDataTerpilah.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Data_siga/kategori/Data_terpilah.dart';
import 'package:siga2/List_item/list_item_data_terpilah.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:siga2/Shimmer/Shimmer_lihat_semua_tahun.dart';
import 'package:flutter/material.dart';

class Berdasarkan_kategori extends StatefulWidget {
  const Berdasarkan_kategori({super.key});

  @override
  State<Berdasarkan_kategori> createState() => _Berdasarkan_kategoriState();
}

class _Berdasarkan_kategoriState extends State<Berdasarkan_kategori> {
  List data = [];
  _getKategoriData_terpilah() {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    getKategoriDataTerpilah().then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      if (value == "terjadi_masalah") {
        Alert(context, "Opsszz", "Terjadi masalah pada internal server");
      }
      if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return No_internet(click: _getKategoriData_terpilah);
            }));
      } else {
        if (mounted)
          setState(() {
            data = jsonDecode(value)["data"];
          });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement
    // initState
    _getKategoriData_terpilah();
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer_lihat_semua_tahun()
        : Container(
            width: double.infinity,
            color: Color.fromARGB(31, 255, 243, 243),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SISTIM INFORMASI GENDER DAN ANAK (SIGA)",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "SIGA Kota Baubau adalah sistim yang di buat untuk memudahkan pengelolaan data terpilah yang berkaitan dengan Gender dan Anak",
                      textAlign: TextAlign.justify,
                    ),
                    for (int i = 0; i < data.length; i++)
                      List_item_data_terpilah(
                        index: i,
                        id_kategori_data_terpilah: data[i]
                            ['id_kategori_data_terpilah'],
                        kategori_data_terpilah: data[i]
                            ["kategori_data_terpilah"],
                        jumlah_data: data[i]["jumlah_data"],
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => Data_terpilah(
                                    id_kategori_data_terpilah: data[i]
                                        ['id_kategori_data_terpilah'],
                                    kategori_data_terpilah: data[i]
                                        ["kategori_data_terpilah"],
                                  )),
                            ),
                          );
                        },
                      )
                  ],
                ),
              ),
            ),
          );
  }
}
