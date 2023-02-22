import 'package:siga2/Api_http/getLihatVideo.dart';
import 'package:flutter/material.dart';

class Lihat_video extends StatefulWidget {
  String id_video;
  String judul;

  Lihat_video({
    super.key,
    required this.id_video,
    required this.judul,
  });

  @override
  State<Lihat_video> createState() => _Lihat_videoState();
}

class _Lihat_videoState extends State<Lihat_video> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lihat",
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 160,
            width: double.infinity,
            color: Colors.black12,
            child: Text("azwr"),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
