import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Componen/SharedPref.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          Icon(
            Icons.info_outline,
            size: 50,
            color: Colors.red,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Perhatian",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Apakan anda ingin logout?"),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Tidak Jadi")),
              SizedBox(
                width: 50,
              ),
              Expanded(
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () async {
                      await SharedPref().remove(await Enviroment.getToken());
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => Login(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Ya, Logout Sekarnag"),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
