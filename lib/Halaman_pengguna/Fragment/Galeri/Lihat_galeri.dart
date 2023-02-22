import 'dart:math';

import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:flutter/material.dart';

class Lihat_galeri extends StatefulWidget {
  var data;
  int pilih;
  Lihat_galeri({super.key, required this.data, required this.pilih});

  @override
  State<Lihat_galeri> createState() => _Lihat_galeriState();
}

class _Lihat_galeriState extends State<Lihat_galeri> {
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  int aktif_foto = 0;
  int pilih = 0;
  @override
  void dispose() {
    pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    setState(() {
      pilih = widget.pilih;
      aktif_foto = widget.pilih;
      pageController = PageController(initialPage: pilih);
      // TODO: implement initState
      print(aktif_foto);

      Future.delayed(Duration(seconds: 1)).then((value) {
        scrollController.animateTo(66 * aktif_foto.toDouble(),
            duration: Duration(milliseconds: 300), curve: Curves.ease);
      });

      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              )),
        ),
        Expanded(
          flex: 4,
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                aktif_foto = value;
                scrollController.animateTo((aktif_foto * 67),
                    duration: Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              });
            },
            controller: pageController,
            children: [
              for (int i = 0; i < widget.data.length; i++)
                Container(
                  margin: EdgeInsets.all(5),
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                      child: ImageNetwork(
                          url: widget.data[i]["img_future"],
                          height_gambar: double.infinity)),
                ),
            ],
          ),
        ),
        SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < widget.data.length; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      aktif_foto = i;
                      pageController.animateToPage(i,
                          duration: Duration(milliseconds: 1000),
                          curve: Curves.ease);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    width: 70,
                    height: 70,
                    color: Color.fromARGB(255, 23, 23, 23),
                    child: Opacity(
                      opacity: aktif_foto == i ? 1 : 0.3,
                      child: ImageNetwork(
                          url: widget.data[i]["img_future"], height_gambar: 70),
                    ),
                  ),
                ),
            ],
          ),
        )
      ]),
    );
  }
}
