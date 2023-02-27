import 'dart:convert';

import 'package:siga2/Api_http/Siga/getDataTerpilah_kategori.dart';
import 'package:siga2/Api_http/getDataTerpilah.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Indikator_kuisioner.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Pilih_tahun.dart';
import 'package:siga2/Shimmer/Shimmer_data_terpilah.dart';
import 'package:flutter/material.dart';

class Data_terpilah extends StatefulWidget {
  String id_kategori_data_terpilah;
  String kategori_data_terpilah;
  Data_terpilah({
    super.key,
    required this.id_kategori_data_terpilah,
    required this.kategori_data_terpilah,
  });

  @override
  State<Data_terpilah> createState() => _Data_terpilahState();
}

class _Data_terpilahState extends State<Data_terpilah> {
  List data = [];
  _getData() {
    setState(() {
      isLoading = true;
    });
    getDataTerpilah_kategori(widget.id_kategori_data_terpilah).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "terjadi_masalah") {
        Alert(context, "Oppsz", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) => No_internet(click: _getData)));
      } else {
        setState(() {
          data = jsonDecode(value)["data"];
        });
      }
    });
  }

  @override
  void initState() {
    _getData();
    // TODO: implement initState
    super.initState();
  }

  String pId_data_terpilah = "";
  String pId_instansi = "";
  String pLabel_tabel = "";
  String pData_terpilah = "";

  void setTahun(String id_tahun, String tahun) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return Indikator_kuisioner(
        id_data_terpilah: pId_data_terpilah,
        id_instansi: pId_instansi,
        data_terpilah: pData_terpilah,
        id_tahun: id_tahun,
        label_table: pLabel_tabel,
        tahun: tahun,
      );
    })));
  }

  _pilihTahun() {
    showModalBottomSheet(
        context: context,
        builder: ((context) {
          return Pilih_tahun(callBack: setTahun);
        }));
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
        title: Text(
          widget.kategori_data_terpilah,
          style: TextStyle(fontSize: 13),
        ),
      ),
      body: isLoading
          ? Shimmer_data_terpilah()
          : SingleChildScrollView(
              child: Column(children: [
                for (int i = 0; i < data.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text("${i + 1}"),
                      ),
                      title: Container(
                        decoration: BoxDecoration(
                            color: i % 2 == 0
                                ? Color.fromARGB(99, 252, 197, 149)
                                : Color.fromARGB(98, 159, 149, 252),
                            borderRadius: BorderRadius.circular(6)),
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data[i]["data_terpilah"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            Text(
                              "Sumber Data : " + data[i]["label_tabel"],
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black26),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                          color: Colors.black,
                          onPressed: () {
                            pLabel_tabel = data[i]["label_tabel"];
                            pData_terpilah = data[i]["data_terpilah"];
                            pId_instansi = data[i]["id_instansi"];
                            pId_data_terpilah = data[i]['id_data_terpilah'];
                            _pilihTahun();
                          },
                          icon: Icon(Icons.chevron_right_sharp)),
                    ),
                  )
              ]),
            ),
    );
  }
}
