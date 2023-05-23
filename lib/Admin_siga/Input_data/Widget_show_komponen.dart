import 'package:flutter/material.dart';

class Widget_show_komponen extends StatefulWidget {
  List data = [];
  Widget_show_komponen({super.key, required this.data});

  @override
  State<Widget_show_komponen> createState() => _Widget_show_komponenState();
}

class _Widget_show_komponenState extends State<Widget_show_komponen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
        ),
        for (int i = 0; i < widget.data.length; i++)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.data[i]["komponen_nilai"],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Container(
                height: 5,
              ),
              for (int c = 0; c < widget.data[i]["sub_komponen"].length; c++)
                Text(
                  widget.data[i]["sub_komponen"][c]["sub_komponen_nilai"] +
                      " : " +
                      widget.data[i]["sub_komponen"][c]["nilai"],
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              Container(
                height: 10,
              ),
            ],
          )
      ],
    ));
  }
}
