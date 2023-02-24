import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Tahun ${widget.tahun}",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
