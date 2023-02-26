import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:percentify/components/RectCircularPercentify.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admGet_data_teprilah.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Input_data/Adm_Indikator_kuisioner.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';

class Data_terpilah extends StatefulWidget {
  String id_tahun;
  String tahun;

  Data_terpilah({
    super.key,
    required this.id_tahun,
    required this.tahun,
  });

  @override
  State<Data_terpilah> createState() => _Data_terpilahState();
}

class _Data_terpilahState extends State<Data_terpilah> {
  bool isLoading = false;
  List data_terpilah = [];
  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  _init() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    var a = Autentifikasi();
    a.getTime(context, null);
    String header = await a.createHeaderToken();
    Map<String, dynamic> dataLogin = await a.getLoginData();
    String id_instansi = dataLogin["id_instansi"];
    admGetDataTerpilah(
      dataLogin["id_instansi"],
      header,
      widget.tahun,
      widget.id_tahun,
    ).then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      if (value == "terjadi_masalah") {
        Alert(context, "Opzz", "Terjadi masalah");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return No_internet(
                  click: admGetDataTerpilah(
                      id_instansi, header, widget.tahun, widget.id_tahun));
            }));
      } else {
        String status = jsonDecode(value)["status"];
        if (status == "invalid_token") {
          Alert(context, "Indvalid Token", "Anda harus login lagi")
              .then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return Login();
            }));
          });
        } else {
          String status = jsonDecode(value)["status"];
          if (status == "token_invalid") {
            Alert(context, "Terjadi masalah", "Invalid Token").then((value) {
              Navigator.pushReplacementNamed(context, Login.routeName);
            });
          } else {
            if (mounted)
              setState(() {
                data_terpilah = jsonDecode(value)["data"];
              });
          }
        }
      }
    });
  }

  _navigasi_ke_data_terpilah(String id_data_terpilah, String data_terpilah) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Adm_Indikator_kuisioner(
          id_data_terpilah: id_data_terpilah,
          data_terpilah: data_terpilah,
          id_tahun: widget.id_tahun,
          tahun: widget.tahun,
        );
      },
    )).then((value) => {
          if (value == "refresh") {_init()}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Tahun ${widget.tahun}",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.all(15.0),
              child: Shimmer_admin_home(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pilih Data Terpilah",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    for (int i = 0; i < data_terpilah.length; i++)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              child: RectCircularPercentify(
                                  (data_terpilah[i]["persentase"])
                                      .toDouble(), // the value of progress
                                  backgroundColor:
                                      Color.fromARGB(255, 138, 138, 138),
                                  valueColor: data_terpilah[i]["persentase"] ==
                                          0
                                      ? Color.fromARGB(255, 253, 39, 35)
                                      : data_terpilah[i]["persentase"] > 20
                                          ? Color.fromARGB(255, 213, 94, 30)
                                          : Color.fromARGB(255, 35, 125, 253),
                                  strokeWidth: 3,
                                  child: SizedBox(
                                    child: Text(
                                      data_terpilah[i]["persentase"]
                                              .toString() +
                                          "%",
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
                              margin: EdgeInsets.all(12),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: i % 2 == 0
                                      ? Color.fromARGB(41, 250, 36, 122)
                                      : Color.fromARGB(41, 68, 36, 250)),
                              child: Text(data_terpilah[i]["data_terpilah"]),
                            )),
                            IconButton(
                                tooltip: "Pilh Data",
                                onPressed: () {
                                  _navigasi_ke_data_terpilah(
                                    data_terpilah[i]["id_data_terpilah"],
                                    data_terpilah[i]["data_terpilah"],
                                  );
                                },
                                icon: Icon(
                                  CupertinoIcons.chevron_right_circle_fill,
                                  color: Color.fromARGB(147, 0, 0, 0),
                                  size: 30,
                                )),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
