import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';

class No_internet extends StatefulWidget {
  dynamic click;
  No_internet({super.key, required this.click});

  @override
  State<No_internet> createState() => _No_internetState();
}

class _No_internetState extends State<No_internet> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GifView.asset(
            'assets/images/no_internet.gif',
            height: 200,
            frameRate: 30,
          ),
          Text(
            "Oppss!",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Tidak ada koneksi internet",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Silahkan cek koneksi interent anda pastikan menggunakan koneksi yang stabil",
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            child: OutlinedButton(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text("Coba Lagi"),
              ),
              onPressed: () async {
                await widget.click();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
