import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:siga2/Admin_siga/AUTENTIFIKASi.dart';
import 'package:siga2/Admin_siga/ENVIROMENT.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Admin_siga/Pengaturan/Ubah_password.dart';
import 'package:siga2/Admin_siga/Pengaturan/Ubah_username.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Componen/SharedPref.dart';
import 'package:siga2/Config.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String id_instansi = "";
  String nama_instansi = "";
  String username = "";
  init() async {
    var auth = await Autentifikasi();
    Map<String, dynamic> dataLogin = await auth.getLoginData();
    setState(() {
      id_instansi = dataLogin["id_instansi"];
      nama_instansi = dataLogin["nama_instansi"];
      username = dataLogin["username"];
    });
  }

  @override
  void initState() {
    init();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Profil Instansi",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    nama_instansi,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Username : " + username,
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Menu",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Ubah_username();
                },
              ));
            },
            leading: Icon(Icons.person),
            title: Text("Ubah Username"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Ubah_password(),
                  ));
            },
            leading: Icon(Icons.password),
            title: Text("Ubah Password"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Alert(
                context,
                "Tentang",
                "SISTIM INFOMASI GENDER DAN ANAK\n\nVERSION ${VERSI}\nCompileD by Google Flutter ${FLUTTER_VERSI}",
              );
            },
            leading: Icon(Icons.details),
            title: Text("Tentang Siga"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(),
          Expanded(child: Container()),
          Divider(),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(209, 255, 82, 82)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("LOGOUT"),
              ),
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 160,
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Icon(
                              Icons.info,
                              size: 50,
                            ),
                            Text("Apakah anda ingin logout?"),
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Tidak")),
                                ),
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      onPressed: () async {
                                        SharedPref().remove(
                                            await Enviroment.getToken());
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ));
                                      },
                                      child: Text("Logout")),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
