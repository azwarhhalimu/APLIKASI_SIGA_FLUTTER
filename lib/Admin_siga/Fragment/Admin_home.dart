import 'dart:convert';
import 'dart:ui';

import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/Api_admin/getHome_dashboard.dart';
import 'package:siga2/Admin_siga/Api_admin/getTimeZone.dart';
import 'package:siga2/Admin_siga/Fragment/part_home/Home_data_terpilah.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';
import 'package:flutter/material.dart';

import '../ENVIROMENT.dart';

class Admin_home extends StatefulWidget {
  Admin_home({super.key});

  @override
  State<Admin_home> createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  String nama_instansi = "";
  String username = "";
  String alamat = "";
  String id_instansi = "";
  String url = "";
  String token = "";
  bool isLoading = false;
  List data_siga = [];
  String? getLoginData = "";

  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    setState(() {
      isLoading = true;
    });
    await _getLoginData();
    await _getTime();
    _getDashboard_home();
  }

  void _getDashboard_home() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });

    var auth = Autentifikasi();
    await auth.getTime(context, null);
    String header = await auth.createHeaderToken();
    Map<String, dynamic> dataLogin = await auth.getLoginData();
    getHomeDashboard(dataLogin["username"], header, dataLogin["id_instansi"])
        .then((value) {
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
              return No_internet(click: _getTime());
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
        } else if (value == "token_expired") {
          Alert(context, "Failad Auth", "Token Expired").then((value) {
            Navigator.pushReplacementNamed(context, Login.routeName);
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
                data_siga = jsonDecode(value)["data"];
              });
          }
        }
      }
    });
  }

  _getLoginData() async {
    var getData_login = await SharedPref().getData(await Enviroment.getToken());
    Map<String, dynamic> getData = await jsonDecode(getData_login);
    setState(() {
      token = getData["token"];
      nama_instansi = getData["nama_instansi"];
      username = getData["username"];
      alamat = getData["alamat"];
      id_instansi = getData["id_instansi"];
      url = baseUrl("images/logo?f=" + id_instansi + "&w=100&h=100");
    });
  }

// yang di kopi
  int percobaan_login = 0;
  _getTime() async {
    await getTimeZone().then((value) async {
      if (value == "no_internet") {
        _getTime();
        if (percobaan_login > 3) {
          showModalBottomSheet(
              context: context,
              builder: ((context) {
                return No_internet(click: _getLoginData());
              }));
        } else {
          percobaan_login = 0;
        }
        percobaan_login++;
      } else if (value == "terjadi_masalah") {
        Alert(context, "Opzz..", "Terjadi masalah");
      } else {
        await SharedPref().setData("time_zone", value);
        //sukses

        //callback kopi
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Container(
              width: double.infinity,
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo_siga.png",
                    width: 30,
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dashboard",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        nama_aplikasi,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.white),
                      ),
                      Text(
                        "Kota Baubau, Sulawesi Tenggara",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: Row(children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nama_instansi,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    "@" + username,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    alamat,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: 50,
                              height: 50,
                              child: Container(
                                child:
                                    ImageNetwork(url: url, height_gambar: 49),
                              ),
                            )
                          ]),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    transform: Matrix4.translationValues(0, -40, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: isLoading
                        ? Shimmer_admin_home()
                        : Home_data_terpilah(data: data_siga),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
