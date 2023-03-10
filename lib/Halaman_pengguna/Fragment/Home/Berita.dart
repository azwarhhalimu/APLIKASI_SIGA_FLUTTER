import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:siga2/Api_http/getBeranda.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/EncRc4.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Lihat_semua_instansi.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Semua_berita.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Part_page/Berita_utama.dart';
import 'package:siga2/List_item/list_item_banner_home.dart';
import 'package:siga2/List_item/list_item_berita_home.dart';
import 'package:siga2/List_item/list_item_instansi_home.dart';
import 'package:siga2/Shimmer/Shimmer_home_berita.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

import '../Part_page/Kepala_dinas.dart';

class Berita extends StatefulWidget {
  const Berita({super.key});

  @override
  State<Berita> createState() => _BeritaState();
}

class _BeritaState extends State<Berita> {
  var data;
  String foto_walikota = "";
  String foto_wakil_walikota = "";
  String walikota = "";
  String wakil_walikota = "";

  String kepala_dinas = "";
  String foto_kepala_dinas = "";

  List slide_show = [];
  List instansi = [];
  List berita_terbaru = [];
  List banner = [];
  List berita = [];
  _getBeranda() {
    if (mounted)
      setState(() {
        loading = true;
      });
    getBeranda().then((value) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }

      if (value == "terjadi_masalah") {
        Alert(context, "Perhatian", "Terjadi masalah");
      } else if (value == "no_internet") {
        Alert(context, "Perhatian", "Periksa koneksi internet anda")
            .then((value) {
          _getBeranda();
        });
      } else {
        if (mounted) {
          setState(() {
            data = jsonDecode(value);

            foto_walikota = data["foto_walikota"];
            foto_wakil_walikota = data["foto_wakil_walikota"];
            wakil_walikota = data["wakil_walikota"];
            walikota = data["walikota"];

            foto_kepala_dinas = data["foto_kepala_dinas"];
            kepala_dinas = data["kepala_dinas"];

            slide_show = data["slide_show"];
            instansi = data["instansi"];
            berita_terbaru = data["berita_terbaru"];
            banner = data["banner"];

            berita = data["berita"];
          });
        }
      }
    });
  }

  @override
  void dispose() {
    if (mounted) {}
    // TODO: implement dispose
    super.dispose();
  }

  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    _getBeranda();
    super.initState();
  }

  _lihat_semua_instansi() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: ((context) => Lihat_semua_instansi()),
    );
  }

  int a = 0;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Shimmer_home_berita()
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(encryptRC4("azwar", "okos")),
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  color: Color.fromARGB(49, 241, 106, 3),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        child: Marquee(
                          text:
                              "Selamat datanga di Sistim Informasi Gender dan Anak | Dinas Pemberdayaan Perempuan dan Perlindungan Anak Kota Baubau ",
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Jika ada masalah dalam proses penginputan hubungi 082349189692',
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                CarouselSlider(
                  items: [
                    for (int i = 0; i < slide_show.length; i++)
                      Container(
                        padding: EdgeInsets.all(7),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: ImageNetwork(
                            url: slide_show[i]["url"],
                            height_gambar: 90,
                          ),
                        ),
                      )
                  ],
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.6,
                    // enlargeStrategy: CenterPageEnlargeStrategy.height,
                    enlargeCenterPage: false,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sumber Data Aplikasi Siga",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        child: Text("Lihat Semua"),
                        onPressed: () {
                          _lihat_semua_instansi();
                        },
                      )
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 0; i < instansi.length; i++)
                        List_item_instansi_home(
                          nama_instansi: instansi[i]["nama_instansi"],
                          id_instansi: instansi[i]["id_instansi"],
                          logo: instansi[i]["logo"],
                        ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(29, 233, 130, 19)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Walikota Baubau & Wakil Walikota Baubau",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ImageNetwork(
                                      height_gambar: 70,
                                      url: foto_walikota,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Walikota Baubau",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  walikota,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: ImageNetwork(
                                        height_gambar: 70,
                                        url: foto_wakil_walikota,
                                      )),
                                ),
                                Text(
                                  "Wakil Walikota Baubau",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  wakil_walikota,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Kepala_dinas(
                    nama_kepala_dinas: kepala_dinas, foto: foto_kepala_dinas),

                Berita_utama(
                  data: berita,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Berita Terbaru",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Semua_berita(),
                                ));
                          },
                          child: Text("Lihat Semua"))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      for (int i = 0; i < berita_terbaru.length; i++)
                        List_item_berita_home(
                          id_berita: berita_terbaru[i]["id_berita"],
                          judul_berita: berita_terbaru[i]["judul_berita"],
                          tanggal: berita_terbaru[i]["tanggal"],
                          img: berita_terbaru[i]["img"],
                        ),
                      SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                for (int i = 0; i < banner.length; i++)
                  List_item_banner_home(
                    url: banner[i]["url"],
                  )
              ],
            ),
          );
  }
}
