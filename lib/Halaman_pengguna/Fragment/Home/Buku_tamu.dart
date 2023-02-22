import 'dart:convert';

import 'package:siga2/Api_http/getBukuTamu.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Buku_tamu_baru.dart';
import 'package:siga2/Shimmer/Shimmer_buku_tamu.dart';
import 'package:flutter/material.dart';

class Buku_tamu extends StatefulWidget {
  const Buku_tamu({super.key});

  @override
  State<Buku_tamu> createState() => _Buku_tamuState();
}

class _Buku_tamuState extends State<Buku_tamu> {
  List data = [];

  _getData() {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    getBukuTamu().then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (value == "terjadi_masalah") {
        Alert(context, "Opss", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) => No_internet(
                  click: _getData,
                )));
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
    _getData();
    // TODO: implement initState
    super.initState();
  }

  _tambah_buku_tamu() {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return Buku_tamu_baru();
    }))).then((value) {
      if (value == "refresh") {
        _getData();
      }
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Buku Tamu",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              ElevatedButton.icon(
                  onPressed: () {
                    _tambah_buku_tamu();
                  },
                  icon: Icon(Icons.add),
                  label: Text("Pesan Baru"))
            ],
          ),
        ),
        Container(
          color: Colors.black12,
          width: double.infinity,
          height: 1,
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? Shimmer_buku_tamu()
                        : Column(
                            children: [
                              for (int i = 0; i < data.length; i++)
                                Container(
                                  margin: EdgeInsets.only(bottom: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: i % 2 == 0
                                          ? Color.fromARGB(17, 54, 236, 187)
                                          : Color.fromARGB(17, 236, 157, 54)),
                                  child: ListTile(
                                    title: Text(data[i]["nama"]),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data[i]["pesan"]),
                                        Text(data[i]["email"]),
                                      ],
                                    ),
                                    trailing: Text(
                                      data[i]["tanggal"],
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                            ],
                          )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
