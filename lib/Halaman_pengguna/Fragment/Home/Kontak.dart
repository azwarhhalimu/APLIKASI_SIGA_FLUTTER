import 'package:flutter/material.dart';

class Kontak extends StatefulWidget {
  const Kontak({super.key});

  @override
  State<Kontak> createState() => _KontakState();
}

class _KontakState extends State<Kontak> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kontak",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Dinas Pemberdayaan Perempuan dan Perlindungan Anak Kota Baubua",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Jalan Cut Nyk Dian No.1\nKelurahan Bautaulo, Kecamatan Wolio\nKota Baubau, Sulawesi Tenggara"),
              SizedBox(
                height: 20,
              ),
              Text(
                "Telepon dan Fax",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text("Office : - "),
              Text("Fax : - "),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Text("dp3abaubaukota@gmail.com"),
            ],
          ),
        )
      ],
    );
  }
}
