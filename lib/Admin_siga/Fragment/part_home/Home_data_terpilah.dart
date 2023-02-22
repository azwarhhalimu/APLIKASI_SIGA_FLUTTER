import 'package:flutter/material.dart';

class Home_data_terpilah extends StatefulWidget {
  List data;
  Home_data_terpilah({super.key, required this.data});

  @override
  State<Home_data_terpilah> createState() => _Home_data_terpilahState();
}

class _Home_data_terpilahState extends State<Home_data_terpilah> {
  List data = [];
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          Text(
            "Data Terpilah",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          for (int i = 0; i < widget.data.length; i++)
            ListTile(
              contentPadding: EdgeInsets.all(5),
              title: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.01, 0.01],
                      colors: i % 2 == 0
                          ? [Colors.blue, Color.fromARGB(69, 48, 154, 246)]
                          : [
                              Color.fromARGB(255, 202, 0, 0),
                              Color.fromARGB(61, 245, 57, 43)
                            ]),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(widget.data[i]["data_terpilah"]),
              ),
            )
        ],
      ),
    );
  }
}
