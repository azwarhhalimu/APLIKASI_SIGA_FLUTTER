import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/admGetIndikatorKuisioner.dart';
import 'package:siga2/Admin_siga/Input_data/Adm_input_kuisioner.dart';
import 'package:siga2/Admin_siga/Input_data/Adm_input_kuisioner_via_indikator.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:siga2/Shimmer/Shimmer_indikator_kuisioner.dart';

class Adm_Indikator_kuisioner extends StatefulWidget {
  String id_data_terpilah;
  String data_terpilah;
  String id_tahun;
  String tahun;

  Adm_Indikator_kuisioner({
    super.key,
    required this.id_data_terpilah,
    required this.data_terpilah,
    required this.id_tahun,
    required this.tahun,
  });

  @override
  State<Adm_Indikator_kuisioner> createState() =>
      _Adm_Indikator_kuisionerState();
}

class _Adm_Indikator_kuisionerState extends State<Adm_Indikator_kuisioner> {
  List data = [];
  bool isLoading = false;
  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  init() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    var auth = Autentifikasi();
    await auth.getTime(context, init);
    Map<String, dynamic> loginData = await auth.getLoginData();
    String id_instansi = loginData["id_instansi"];
    String haeder = await auth.createHeaderToken();

    await admGetIndikatorKuisioner(
            haeder, id_instansi, widget.id_data_terpilah, widget.id_tahun)
        .then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      if (value == "terjadi_masalah") {
        Alert(context, "Opzz", "Internal server bermasalah");
      } else if (value == "no_internet") {
        Alert(context, "Oppzz", "Periksa kembali koneksi internet anda")
            .then((value) {
          init();
        });
      } else {
        String status = jsonDecode(value)["status"];
        if (status == "auth_ok") {
          if (mounted) {
            setState(() {
              data = jsonDecode(value)["data"];
            });
          }
          print(data);
        } else {
          Alert(context, "Error", "Token tidak valid. Silahkan login kembali")
              .then((value) => Navigator.pushNamed(context, Login.routeName));
        }
      }
    });
  }

  String refresh = "";

  void _input(String id_indikator_kuisioner, String indikator_kuisioner,
      String laki_laki, String perempuan, List komponen_nilai) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        if (komponen_nilai.length > 0) {
          return Adm_input_input_kuisioner_via_indikator(
            komponen_nilai: komponen_nilai,
            id_data_terpilah: widget.id_data_terpilah,
            id_tahun: widget.id_tahun,
            id_indikator_kuisioner: id_indikator_kuisioner,
          );
        } else {
          return Adm_input_kuisioner(
            data_terpilah: widget.data_terpilah,
            indikator_kuisioner: indikator_kuisioner,
            id_indikator_kuisioner: id_indikator_kuisioner,
            id_data_terpilah: widget.id_data_terpilah,
            tahun: widget.tahun,
            id_tahun: widget.id_tahun,
            laki_laki: laki_laki,
            perempuan: perempuan,
          );
        }
      },
    ).then((value) {
      if (value == "refresh") {
        init();
        refresh = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, refresh);
          },
          icon: Icon(Icons.close),
        ),
        title: Text(
          "Input Data Tahun " + widget.tahun,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),
      body: isLoading
          ? Shimmer_data_terpilah()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data_terpilah,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Input Data Indikator Kuisioner ",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),

                    //list data
                    for (int i = 0; i < data.length; i++)
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo,
                          child: Text((i + 1).toString()),
                        ),
                        contentPadding: EdgeInsets.all(0),
                        title: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: i % 2 == 0
                                  ? Color.fromARGB(66, 241, 121, 121)
                                  : Color.fromARGB(66, 241, 205, 121),
                              borderRadius: BorderRadius.circular(4)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data[i]["indikator_kuisioner"]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Laki-laki : ${data[i]['laki_laki']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Perempuan :  ${data[i]['perempuan']}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            _input(
                                data[i]["id_indikator_kuisioner"],
                                data[i]["indikator_kuisioner"],
                                data[i]["laki_laki"],
                                data[i]["perempuan"],
                                data[i]["komponen_nilai"]);
                          },
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
