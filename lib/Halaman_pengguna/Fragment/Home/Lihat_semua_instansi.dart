import 'dart:convert';

import 'package:siga2/Api_http/getSemuaInstansi.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Data_terpilah.dart';
import 'package:siga2/Shimmer/Shimmer_semua_instansi.dart';
import 'package:flutter/material.dart';

class Lihat_semua_instansi extends StatefulWidget {
  const Lihat_semua_instansi({super.key});

  @override
  State<Lihat_semua_instansi> createState() => _Lihat_semua_instansiState();
}

class _Lihat_semua_instansiState extends State<Lihat_semua_instansi> {
  List data = [];
  String cari = "";
  _getSemuaInstansi() {
    setState(() {
      loading = true;
    });
    getSemuaInstansi().then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }

      if (value == "terjadi_salah") {
        Alert(context, "Opss", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        Alert(context, "Opsss", "Periksa sambungan ineternet anda")
            .then((value) {
          _getSemuaInstansi();
        });
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    mounted;
    super.dispose();
  }

  bool isCari = false;

  bool loading = false;
  @override
  void initState() {
    _getSemuaInstansi();
    // TODO: implement initState
    super.initState();
  }

  String a = "0";
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.90,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              Expanded(
                child: Text(
                  "Lihat Semua Instansi",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isCari = isCari == true ? false : true;
                      cari = "";
                    });
                  },
                  icon: Icon(isCari ? Icons.close : Icons.search))
            ],
          ),
          isCari
              ? Container(
                  child: TextFormField(
                    onChanged: ((value) {
                      setState(() {
                        cari = value;
                      });
                    }),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                        hintText: "Masukkan pencarian"),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          loading
              ? Shimmer_semua_instansi()
              : Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        var setData = data[index];
                        if (setData["nama_instansi"]
                            .toString()
                            .toLowerCase()
                            .contains(cari.toLowerCase())) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return Data_terpilah(
                                    nama_instansi: setData["nama_instansi"],
                                    id_instansi: setData["id_instansi"]);
                              })));
                            },
                            leading: Image.network(
                              setData["images"],
                              width: 26,
                            ),
                            title: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: index % 2 == 0
                                      ? Color.fromRGBO(247, 228, 179, 0.66)
                                      : Color.fromRGBO(179, 206, 247, 0.659)),
                              child: Text(setData["nama_instansi"]),
                            ),
                            trailing: Icon(Icons.chevron_right),
                          );
                        }
                        return Container();
                      })),
                )
        ],
      ),
    );
  }
}
