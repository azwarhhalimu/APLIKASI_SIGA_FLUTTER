import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Baca_berita.dart';
import 'package:flutter/material.dart';

class List_item_berita_home extends StatelessWidget {
  String id_berita;
  String judul_berita;
  String tanggal;
  String img;
  List_item_berita_home({
    super.key,
    required this.id_berita,
    required this.judul_berita,
    required this.tanggal,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.389;
    return Container(
      margin: EdgeInsets.only(left: 12),
      width: width,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => Baca_berita(id_berita: id_berita)),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: ImageNetwork(url: img, height_gambar: 90),
            ),
            Container(
              height: 35,
              child: Text(
                judul_berita,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            Text(
              tanggal,
              style: TextStyle(
                fontSize: 10,
                color: Color.fromARGB(255, 122, 125, 127),
              ),
            )
          ],
        ),
      ),
    );
  }
}
