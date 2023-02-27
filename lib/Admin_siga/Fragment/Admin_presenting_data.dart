import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart';
import 'package:percentify/components/RectCircularPercentify.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admGet_data_teprilah.dart';
import 'package:siga2/Admin_siga/Fragment/part_presenting_data/Adm_lihat_indikator_kuisioner.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Api_http/getTahun.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';

class Admin_preseting_data extends StatefulWidget {
  Admin_preseting_data({super.key});

  @override
  State<Admin_preseting_data> createState() => _Admin_preseting_dataState();
}

class _Admin_preseting_dataState extends State<Admin_preseting_data> {
  // Cetak hasil enkripsi
  List tahun = [];
  List data = [];
  _getTahun() {
    getTahun().then((value) {
      if (mounted) {
        setState(() {
          tahun = jsonDecode(value)["data"];
          id_tahun = tahun[0]["id_tahun"];
          nama_tahun = tahun[0]["tahun"];
        });
      }
      ;
    });
  }

  String id_tahun = "";
  String nama_tahun = "";
  _getData() async {
    var a = Autentifikasi();
    await a.getTime(context, null);
    String header = await a.createHeaderToken();
    Map<String, dynamic> dataLogin = (await a.getLoginData());

    await admGetDataTerpilah(
            dataLogin["id_instansi"], header, nama_tahun, id_tahun)
        .then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (value == "token_invalid") {
        Alert(context, "Invalid Token", "Silahkan login ulang");
      } else if (value == "terjadi_masalah") {
        Alert(context, "Oppzz", "Internnal server bermasalah");
      } else if (value == "token_expired") {
        Alert(context, "Invalid Expired", "Silahkan login ulang").then((value) {
          Navigator.pushReplacementNamed(context, Login.routeName);
        });
      } else {
        String status = jsonDecode(value)["status"];
        if (status == "data_ok") {
          setState(() {
            data = jsonDecode(value)["data"];
          });
        }
      }
    });
  }

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  init() async {
    setState(() {
      isLoading = true;
    });
    await _getTahun();
    await _getData();
  }

  bool isLoading = false;

  void _lihat_indikator_data_terpilah(
      String id_data_terpilah, String id_tahun, String data_terpilah) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Adm_lihat_indikator_kuisioner(
          id_data_terpilah: id_data_terpilah,
          id_tahun: id_tahun,
          data_terpilah: data_terpilah,
          tahun: nama_tahun,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Preseting Data",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color.fromARGB(31, 168, 168, 168),
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Data Indikator Tahun ${nama_tahun}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                PopupMenuButton(
                  onSelected: (index) {
                    setState(() {
                      isLoading = true;
                      nama_tahun = tahun[index]["tahun"];
                      id_tahun = tahun[index]["id_tahun"];
                      _getData();
                    });
                  },
                  child: Container(
                    child: Text(
                      "Tahun ${tahun.length != 0 ? nama_tahun : "..."}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 1, color: Colors.black26)),
                  ),
                  itemBuilder: (context) => [
                    for (int i = 0; i < tahun.length; i++)
                      PopupMenuItem(
                        value: i,
                        child: Text("Tahun ${tahun[i]['tahun']}"),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: isLoading
                  ? SingleChildScrollView(
                      child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Shimmer_admin_home(),
                    ))
                  : ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        var setData = data[index];
                        return Container(
                          margin: EdgeInsets.only(
                            left: 15,
                            right: 15,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                stops: [0.17, 0.1],
                                colors: index % 2 == 0
                                    ? [
                                        Color.fromARGB(73, 69, 33, 231),
                                        Color.fromARGB(190, 144, 146, 249)
                                      ]
                                    : [
                                        Color.fromARGB(75, 33, 149, 243),
                                        Color.fromARGB(191, 33, 149, 243)
                                      ],
                              )),
                          child: Row(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                child: RectCircularPercentify(
                                    (setData["persentase"])
                                        .toDouble(), // the value of progress
                                    backgroundColor:
                                        Color.fromARGB(255, 138, 138, 138),
                                    valueColor:
                                        Color.fromARGB(255, 255, 61, 50),
                                    strokeWidth: 3,
                                    child: SizedBox(
                                      child: Text(
                                        "${setData["persentase"]}%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.red,
                                            fontSize: 10),
                                      ),
                                    ),
                                    valueStrokeWidth: 6),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(setData["data_terpilah"]),
                                    TextButton(
                                        onPressed: () {
                                          _lihat_indikator_data_terpilah(
                                              setData["id_data_terpilah"],
                                              id_tahun,
                                              setData["data_terpilah"]);
                                        },
                                        child: Text(
                                          "Lihat Data",
                                          style: TextStyle(color: Colors.black),
                                        )),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }
}
