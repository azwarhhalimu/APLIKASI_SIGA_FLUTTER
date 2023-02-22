import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_indikator_kuisioner extends StatelessWidget {
  const Shimmer_indikator_kuisioner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
                Text("Loading")
              ],
            ),
          ),
        ),
        Container(
          child: Column(
            children: [
              for (int i = 0; i < 12; i++)
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.black12,
                  ),
                  title: Shimmer_item(
                      color: Colors.black12,
                      width: MediaQuery.of(context).size.width,
                      height: 50),
                )
            ],
          ),
        ),
      ],
    );
  }
}
