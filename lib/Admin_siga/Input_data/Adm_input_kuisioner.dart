import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Adm_input_kuisioner extends StatefulWidget {
  String data_terpilah;
  String indikator_kuisioner;

  String id_data_terpilah;
  String id_indikator_kuisioner;
  String id_tahun;
  String tahun;

  Adm_input_kuisioner({
    super.key,
    required this.data_terpilah,
    required this.indikator_kuisioner,
    required this.id_data_terpilah,
    required this.id_indikator_kuisioner,
    required this.id_tahun,
    required this.tahun,
  });

  @override
  State<Adm_input_kuisioner> createState() => _Adm_input_kuisionerState();
}

class _Adm_input_kuisionerState extends State<Adm_input_kuisioner> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      height: MediaQuery.of(context).size.height * 0.80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data_terpilah,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.indikator_kuisioner,
            style: TextStyle(color: Colors.black54),
          ),
          Text(
            "Tahun " + widget.tahun,
            style: TextStyle(color: Colors.black54),
          ),
          Divider(),
          Form(
              child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("Laki-laki"),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(9, 0, 0, 0),
                            hintText: "0",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text("perempuan"),
                        TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(9, 0, 0, 0),
                            hintText: "0",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                ],
              )
            ],
          )),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Simpan Data"),
                )),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(202, 244, 67, 54)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Batal"),
                )),
          ),
        ],
      ),
    );
  }
}
