import 'package:carousel_slider/carousel_slider.dart';
import 'package:siga2/Admin_siga/SplashScreen.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Berita.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Buku_tamu.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Kontak.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Video.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Part_page/Kepala_dinas.dart';
import 'package:siga2/List_item/list_item_banner_home.dart';
import 'package:siga2/List_item/list_item_berita_home.dart';
import 'package:siga2/List_item/list_item_instansi_home.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 45,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dinas Pemberdayaan",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Perempuan dan Perlindangan Anak",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "Kota Baubau, Sulawesi Tenggara",
                    style: TextStyle(fontSize: 9),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(221, 118, 118, 118)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return SplashScreen();
                  })));
                },
                child: Text(
                  "Siga\nAdmin",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11),
                )),
          )
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            TabBar(labelColor: Colors.black87, isScrollable: true, tabs: [
              Tab(
                text: "Berita",
              ),
              Tab(
                text: "Video",
              ),
              Tab(
                text: "Kontak",
              ),
              Tab(
                text: "Buku Tamu",
              ),
            ]),
            Expanded(
              child: TabBarView(
                children: [Berita(), Video(), Kontak(), Buku_tamu()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
