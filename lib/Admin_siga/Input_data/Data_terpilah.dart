import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Componen/SharedPref.dart';

class Data_terpilah extends StatefulWidget {
  String id_tahun;
  String tahun;

  Data_terpilah({
    super.key,
    required this.id_tahun,
    required this.tahun,
  });

  @override
  State<Data_terpilah> createState() => _Data_terpilahState();
}

class _Data_terpilahState extends State<Data_terpilah> {
  @override
  void initState() {
    _init();
    // TODO: implement initState
    super.initState();
  }

  _init() async {
    var getUser = await SharedPref().getData(token_login);
    print(getUser);
  }

  final dataMap = <String, double>{
    "Flutter": 5,
  };

  final colorList = <Color>[
    Colors.greenAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Tahun ${widget.tahun}",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pilih Data Terpilah",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              for (int i = 0; i < 20; i++)
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            child: Text(
                              "20%",
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                          Text(
                            "4/9",
                            style: TextStyle(fontSize: 11),
                          )
                        ],
                      ),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.all(12),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromARGB(41, 250, 36, 122)),
                        child: Text("DAta pegawai berdsarkan kelamin"),
                      )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.chevron_right_circle_fill,
                            color: Color.fromARGB(147, 0, 0, 0),
                            size: 30,
                          )),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
