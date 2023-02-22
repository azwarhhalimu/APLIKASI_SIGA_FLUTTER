import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:flutter/material.dart';

class List_item_banner_home extends StatelessWidget {
  String url;
  List_item_banner_home({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ImageNetwork(url: url, height_gambar: 300),
    );
  }
}
