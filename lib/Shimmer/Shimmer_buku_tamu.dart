import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_buku_tamu extends StatelessWidget {
  const Shimmer_buku_tamu({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            top: (MediaQuery.of(context).size.width / 2) - 10,
            left: (MediaQuery.of(context).size.width / 2) - 50,
            child: Column(
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text("Loading"),
              ],
            )),
        Container(
          child: Column(
            children: [
              for (int i = 0; i < 8; i++)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Shimmer_item(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width,
                      height: 70),
                )
            ],
          ),
        ),
      ],
    );
  }
}
