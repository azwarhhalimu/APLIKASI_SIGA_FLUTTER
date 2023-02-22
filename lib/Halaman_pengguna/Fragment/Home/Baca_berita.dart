import 'dart:convert';
import 'package:siga2/Api_http/getBaca_berita.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/List_item/list_item_berita_home.dart';
import 'package:siga2/Shimmer/Shimer_baca_berita.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class Baca_berita extends StatefulWidget {
  String id_berita;
  Baca_berita({super.key, required this.id_berita});

  @override
  State<Baca_berita> createState() => _Baca_beritaState();
}

class _Baca_beritaState extends State<Baca_berita> {
  var data = null;

  String id_tanggal = "";
  String judul = "";
  String tanggal = "";
  String isi = "";
  String image = "";

  List berita_lainnya = [];
  _baca_berita() {
    setState(() {
      loading = true;
    });
    getBacaBerita(widget.id_berita).then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      if (value == "tejadi_masalah") {
        Alert(context, "Oppss", "Terjadi kesalah pada internal server");
      } else {
        if (mounted) {
          setState(() {
            data = jsonDecode(value);
            if (data != null) {
              judul = data["judul"];
              tanggal = data["tanggal"];
              isi = data["isi"];
              image = data["image"];

              berita_lainnya = data["berita_lainnya"];
              print(berita_lainnya);
            }
          });
        }
      }
    });
  }

  bool loading = false;

  @override
  void initState() {
    _baca_berita();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    mounted;
    // TODO: implement dispose
    super.dispose();
  }

  String a = "b";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackButton(
          color: Colors.black87,
        ),
        backgroundColor: Colors.white,
        title: Text(""),
      ),
      body: loading
          ? Shimmer_baca_berita()
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            judul,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(tanggal),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    ImageNetwork(url: image, height_gambar: 200),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: HtmlWidget(
                        isi,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 15,
                        bottom: 15,
                      ),
                      child: Text(
                        "Berita Lainnya",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    for (int i = 0; i < berita_lainnya.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          onTap: () {
                            setState(() {
                              widget.id_berita = berita_lainnya[i]["id_berita"];
                            });
                            _baca_berita();
                          },
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                berita_lainnya[i]["judul"],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              Text(
                                berita_lainnya[i]["tanggal"],
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          trailing: Container(
                            width: 80,
                            height: 80,
                            child: ImageNetwork(
                                url: berita_lainnya[i]["image"],
                                height_gambar: 80),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
