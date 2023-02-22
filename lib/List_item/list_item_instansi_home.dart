import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:flutter/material.dart';

class List_item_instansi_home extends StatelessWidget {
  String id_instansi;
  String nama_instansi;
  String logo;
  List_item_instansi_home({
    super.key,
    required this.id_instansi,
    required this.nama_instansi,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 73,
      margin: EdgeInsets.only(left: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
                color: Color.fromARGB(74, 240, 150, 14),
                borderRadius: BorderRadius.circular(9)),
            padding: EdgeInsets.all(12),
            child: ImageNetwork(
              url: logo,
              height_gambar: 40,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            child: Expanded(
              child: Text(
                nama_instansi,
                style: TextStyle(
                    fontSize: 9, color: Color.fromARGB(255, 194, 85, 1)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
