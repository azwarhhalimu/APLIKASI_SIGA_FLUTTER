import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:flutter/material.dart';

class List_item_berdasarkan_instansi extends StatelessWidget {
  final VoidCallback? onTap;
  int index;
  String nama_instansi;
  String id_instansi;
  String images;

  String jumlah_data;
  List_item_berdasarkan_instansi({
    super.key,
    required this.onTap,
    required this.index,
    required this.nama_instansi,
    required this.id_instansi,
    required this.jumlah_data,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              child: Text("${index + 1}"),
            ),
            Container(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.network(
                          images,
                          width: 40,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${nama_instansi}"),
                              Text("Kota Baubau"),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right)
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(31, 103, 103, 103),
                      ),
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Text("${jumlah_data} Data Terpilah"),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
