import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_admin_home extends StatelessWidget {
  const Shimmer_admin_home({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 14,
              ),
              Shimmer_item(color: Colors.black12, width: 100, height: 20),
              SizedBox(
                height: 14,
              ),
              for (int i = 0; i < 8; i++)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  height: 50,
                  color: Colors.black12,
                )
            ],
          ),
        ),
        Positioned(
            top: (MediaQuery.of(context).size.height / 3.5),
            left: (MediaQuery.of(context).size.height / 5 - 20),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color.fromARGB(170, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 5,
                    ),
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
            ))
      ],
    );
  }
}
