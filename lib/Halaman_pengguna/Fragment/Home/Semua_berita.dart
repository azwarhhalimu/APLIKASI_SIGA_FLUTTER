import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Api_http/getSemua_berita.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Baca_berita.dart';
import 'package:siga2/Shimmer/Shimmer_video.dart';

class Semua_berita extends StatefulWidget {
  const Semua_berita({super.key});

  @override
  State<Semua_berita> createState() => _Semua_beritaState();
}

class _Semua_beritaState extends State<Semua_berita> {
  List data = [];
  _getData() {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    getSemuaBerita().then((value) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (value == "terjadi_masalah") {
        Alert(context, "Opzz", "Terjadi masalah");
      } else if (value == "no_internet") {
        Alert(context, "No Internet", "Periksa kembali keoneksi anda");
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: Colors.black87,
            )),
        backgroundColor: Colors.white,
        title: Text(
          "Semua Berita",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
      body: isLoading
          ? Shimmer_video()
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                var setData = data[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 10, top: 10),
                  child: ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Baca_berita(id_berita: setData["id_berita"]);
                          },
                        ));
                      },
                      trailing: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ImageNetwork(
                            url: setData["img"], height_gambar: 80),
                        width: 80,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            setData["judul_berita"],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            setData["tanggal"],
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      )),
                );
              },
            ),
    );
  }
}
