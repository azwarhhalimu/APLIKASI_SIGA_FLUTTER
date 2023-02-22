import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_baca_berita extends StatelessWidget {
  const Shimmer_baca_berita({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Membuka berita",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer_item(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width - 35,
                      height: 14),
                  SizedBox(
                    height: 10,
                  ),
                  Shimmer_item(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width - 135,
                      height: 14),
                  SizedBox(
                    height: 30,
                  ),
                  Shimmer_item(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width - 35,
                      height: 180),
                  SizedBox(
                    height: 30,
                  ),
                  for (int i = 0; i < 12; i++)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Shimmer_item(
                          color: Colors.black12,
                          width: MediaQuery.of(context).size.width -
                              ((i == 11) ? 250 : 35),
                          height: 20),
                    )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
