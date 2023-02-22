import 'package:flutter/material.dart';

class List_item_data_terpilah extends StatelessWidget {
  String id_kategori_data_terpilah;
  int index;
  String kategori_data_terpilah;
  String jumlah_data;
  final VoidCallback onTap;
  List_item_data_terpilah(
      {super.key,
      required this.index,
      required this.id_kategori_data_terpilah,
      required this.kategori_data_terpilah,
      required this.jumlah_data,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          gradient: LinearGradient(stops: [
            0.01,
            0.01
          ], colors: [
            index % 2 == 0 ? Colors.blue : Colors.orange,
            Colors.white
          ]),
        ),
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(kategori_data_terpilah),
                    Text(
                      "${jumlah_data} Data",
                      style: TextStyle(fontSize: 13, color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_sharp)
            ],
          ),
        ),
      ),
    );
  }
}
