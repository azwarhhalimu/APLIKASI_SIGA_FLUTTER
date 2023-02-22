import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_video extends StatelessWidget {
  const Shimmer_video({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            for (int i = 0; i < 10; i++)
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer_item(
                            color: Colors.black26,
                            width: MediaQuery.of(context).size.width,
                            height: 10),
                        SizedBox(
                          height: 5,
                        ),
                        Shimmer_item(
                            color: Colors.black26,
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 10),
                        SizedBox(
                          height: 5,
                        ),
                        Shimmer_item(
                            color: Colors.black12,
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 10),
                      ],
                    ),
                    trailing: Shimmer_item(
                        color: Colors.black26, width: 70, height: 70)),
              )
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Container(
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Loading",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
