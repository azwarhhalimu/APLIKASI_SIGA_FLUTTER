import 'dart:ui';

import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Baca_berita.dart';
import 'package:flutter/material.dart';

class Berita_utama extends StatelessWidget {
  dynamic data = [];
  Berita_utama({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromARGB(93, 222, 222, 222),
      padding: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Berita utama",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          for (int i = 0; i < data.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) {
                    return Baca_berita(id_berita: data[i]["id_berita"]);
                  })));
                },
                contentPadding: EdgeInsets.all(0),
                leading: null,
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[i]["judul"],
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    ),
                    Text(
                      data[i]["tanggal"],
                      style: TextStyle(fontSize: 12, color: Colors.black45),
                    ),
                  ],
                ),
                trailing: Container(
                  color: Color.fromARGB(255, 66, 66, 66),
                  width: 80,
                  height: 80,
                  child: ClipRRect(
                      child: ImageNetwork(
                          url: baseUrl('images/berita?source=' +
                              data[i]['id_berita'] +
                              "&size=100"),
                          height_gambar: 100)),
                ),
              ),
            )
        ],
      ),
    );
  }
}
