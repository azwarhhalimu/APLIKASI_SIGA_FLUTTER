import 'package:siga2/Shimmer/Shimmer_item.dart';
import 'package:flutter/material.dart';

class Shimmer_home_berita extends StatelessWidget {
  const Shimmer_home_berita({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Harap tunggu",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                color: Colors.black12,
                width: double.infinity,
                child: Column(
                  children: [
                    Shimmer_item(
                        color: Colors.black26,
                        width: MediaQuery.of(context).size.width - 30,
                        height: 10),
                    SizedBox(
                      height: 10,
                    ),
                    Shimmer_item(
                        color: Colors.black26,
                        width: MediaQuery.of(context).size.width * .30,
                        height: 10),
                    SizedBox(
                      height: 10,
                    ),
                    Shimmer_item(
                        color: Colors.black26,
                        width: MediaQuery.of(context).size.width * .50,
                        height: 10),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Shimmer_item(
                        color: Colors.black12,
                        width: MediaQuery.of(context).size.width - 40,
                        height: 120),
                    SizedBox(
                      height: 20,
                    ),
                    Shimmer_item(color: Colors.black12, width: 150, height: 15),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Shimmer_item(
                        color: Colors.black12,
                        width: MediaQuery.of(context).size.width - 40,
                        height: 90),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
