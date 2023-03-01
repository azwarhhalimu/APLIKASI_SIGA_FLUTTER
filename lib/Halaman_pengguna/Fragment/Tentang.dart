import 'package:flutter/material.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Config.dart';

class Tentang extends StatelessWidget {
  const Tentang({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Tentang Aplikasi",
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            color: Colors.blue,
            child: Column(
              children: [
                Image.asset("assets/images/logo_siga.png",
                    width: MediaQuery.of(context).size.width * 0.3),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "SIGA KOTA BAUBAU",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sistim Informasi Gender dan Anak",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Dinas Pemberdayaan Perempuan dan Anal\nKota Baubau, Sulawesi Tenggara",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: (() {
              Alert(
                context,
                "Tentang",
                "SISTIM INFOMASI GENDER DAN ANAK\n\nVERSION ${VERSI}\nCompiled by Google Flutter ${FLUTTER_VERSI}",
              );
            }),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          width: 1, color: Color.fromARGB(25, 0, 0, 0)))),
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Tentang SIGA"), Icon(Icons.chevron_right)],
              ),
            ),
          )
        ],
      ),
    );
  }
}
