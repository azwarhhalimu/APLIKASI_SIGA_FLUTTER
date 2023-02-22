import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Kepala_dinas extends StatelessWidget {
  String nama_kepala_dinas;
  String foto;
  Kepala_dinas(
      {super.key, required this.nama_kepala_dinas, required this.foto});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: 150,
            color: Color.fromARGB(76, 242, 112, 61),
            padding: EdgeInsets.all(0),
            child: SvgPicture.asset(
              "assets/images/bg.svg",
              fit: BoxFit.cover,
              alignment: Alignment.center,
            )),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dinas Pemberdayaan Perempuan dan Perlindungan Anaka Kota Baubau",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(nama_kepala_dinas),
                    Text(
                      "Kepala Dinas",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  foto,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.hide_image,
                      size: 40,
                    );
                  },
                  width: 96,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
