import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:siga2/Admin_siga/Api_admin/getHome_dashboard.dart';
import 'package:siga2/Admin_siga/Fragment/part_home/Home_data_terpilah.dart';
import 'package:siga2/Admin_siga/enviroment.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Componen/Loading_dialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Shimmer/Admin_shimmer/Shimmer_admin_home.dart';
import 'package:flutter/material.dart';

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
  bool isLoading = false;
  List data_siga = [];

  _getLoginData() async {
    SharedPreferences getData = await SharedPreferences.getInstance();
    String? getLoginData = await getData.getString(token_login);
    var data = jsonDecode(getLoginData!);
    setState(() {
      id_instansi = data["id_instansi"];
      nama_instansi = data["nama_instansi"];
      username = data["username"];
      alamat = data["alamat"];
      url = baseUrl("images/logo?f=" + id_instansi + "&w=100&h=100");
    });
  }

  _getData() {
    getHomeDashboard(id_instansi).then((value) {
      print("hasil ${value}");
    });
  }

  @override
  void initState() {
    super.initState();
    _getLoginData();
    _getData();

    // TODO: implement initState
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                    width: 10,
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
                        : Home_data_terpilah(data: []),
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
