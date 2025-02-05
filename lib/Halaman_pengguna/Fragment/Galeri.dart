import 'dart:convert';

import 'package:siga2/Api_http/getGaleri.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Galeri/Lihat_galeri.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Galeri extends StatefulWidget {
  const Galeri({super.key});

  @override
  State<Galeri> createState() => _GaleriState();
}

class _GaleriState extends State<Galeri> {
  @override
  void dispose() {
    // TODO: implement dispose
    mounted;
    super.dispose();
  }

  List data = [];
  _getGaleri() {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    getGaler().then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      print(value);
      if (value == "terjadi_masalah") {
        Alert(context, "Opps", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        Alert(context, "Terjadi Masalah",
                "Mohon periksa kembali sambungan internet anda")
            .then((value) {
          _getGaleri();
        });
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
    // TODO: implement initState
    _getGaleri();
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Galeri Foto",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 5,
                      )),
                  Text("Loading"),
                ],
              ),
            )
          : GridView.count(
              crossAxisCount: 4,
              children: [
                for (int i = 0; i < data.length; i++)
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return Lihat_galeri(
                          data: data,
                          pilih: i,
                        );
                      })));
                    },
                    child: Container(
                      margin: EdgeInsets.all(1),
                      width: double.infinity,
                      child: ImageNetwork(
                          url: baseUrl("images/galeri?size=200&target=" +
                              data[i]["id_galeri"]),
                          height_gambar: 300),
                    ),
                  ),
              ],
            ),
    );
  }
}
