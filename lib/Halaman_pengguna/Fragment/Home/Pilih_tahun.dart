import 'dart:convert';

import 'package:siga2/Api_http/getTahun.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:flutter/material.dart';

class Pilih_tahun extends StatefulWidget {
  dynamic callBack;
  Pilih_tahun({super.key, required this.callBack});

  @override
  State<Pilih_tahun> createState() => _Pilih_tahunState();
}

class _Pilih_tahunState extends State<Pilih_tahun> {
  List data_tahun = [];
  bool isLoading = false;
  _getTahun() {
    setState(() {
      isLoading = true;
    });
    getTahun().then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "terjadi_masalah") {
        Alert(context, "Gagal", "Internal server bermasalah. coba lagi")
            .then((value) {
          _getTahun();
        });
      } else {
        setState(() {
          data_tahun = jsonDecode(value)["data"];
        });
      }
    });
  }

  @override
  void initState() {
    _getTahun();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pilih tahun",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Loading")
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: data_tahun.length,
                    itemBuilder: (context, index) {
                      var setData = data_tahun[index];
                      return Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(15),
                                elevation: 0,
                                shadowColor:
                                    Color.fromARGB(255, 202, 226, 246)),
                            onPressed: () {
                              widget.callBack(
                                  setData["id_tahun"], setData["tahun"]);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                setData["tahun"],
                              ),
                            )),
                      );
                    },
                  ),
          ),
          SizedBox(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Tutup"),
                )),
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
