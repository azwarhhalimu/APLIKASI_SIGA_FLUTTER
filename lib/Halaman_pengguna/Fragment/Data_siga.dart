import 'package:siga2/Halaman_pengguna/Fragment/Data_siga/Beradasarkan_kategori.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Data_siga/Berasarkan_instansi.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Data_siga extends StatefulWidget {
  const Data_siga({super.key});

  @override
  State<Data_siga> createState() => _Data_sigaState();
}

class _Data_sigaState extends State<Data_siga> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Kategori Data Terpilah",
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            TabBar(
                labelStyle: TextStyle(fontSize: 13),
                dragStartBehavior: DragStartBehavior.start,
                isScrollable: false,
                unselectedLabelColor: Colors.black87,
                labelColor: Colors.blue,
                tabs: [
                  Tab(
                    text: "Berdasarkan Kategori",
                  ),
                  Tab(
                    text: "Berdasarkan Instansi",
                  ),
                ]),
            Expanded(
                child: TabBarView(children: [
              Berdasarkan_kategori(),
              Berasarkan_instansi(),
            ])),
          ],
        ),
      ),
    );
  }
}
