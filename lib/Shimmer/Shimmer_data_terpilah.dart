import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_data_terpilah extends StatelessWidget {
  const Shimmer_data_terpilah({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    color: Colors.white,
                  ),
                  width: 20,
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Shimmer_item(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width,
                  height: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Shimmer_item(
                  color: Colors.black12,
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: 15),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: Shimmer_item(
                          color: Colors.black12, width: 30, height: 30),
                      title: Shimmer_item(
                          color: Colors.black12,
                          width: MediaQuery.of(context).size.width,
                          height: 60),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.black12,
                      ),
                    );
                  })),
            ),
          ],
        ),
      ],
    );
  }
}
