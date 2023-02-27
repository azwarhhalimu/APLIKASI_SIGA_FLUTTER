import 'package:flutter/services.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Data_siga.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Galeri.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Tentang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Halaman_utama extends StatefulWidget {
  static String routeName = "/";
  const Halaman_utama({super.key});

  @override
  State<Halaman_utama> createState() => _Halaman_utamaState();
}

class _Halaman_utamaState extends State<Halaman_utama> {
  List fragment = <Widget>[
    Home(),
    Galeri(),
    Data_siga(),
    Tentang(),
  ];
  int selected = 0;

  _pop() {
    if (selected > 0) {
      setState(() {
        selected = 0;
      });
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(40),
            height: 270,
            child: Column(
              children: [
                Icon(
                  Icons.info_rounded,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Apakah anda ini keluar dari aplikasi ini?"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Jangan dulu")),
                    ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text("Ya Keluar"))
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: fragment[selected],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                selected = value;
              });
            },
            currentIndex: selected,
            selectedLabelStyle: TextStyle(fontSize: 12),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image_outlined), label: "Galeri"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.data_array), label: "Data Siga"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline), label: "Tentang"),
            ],
          ),
        ),
        onWillPop: () async {
          return _pop();
        });
  }
}
