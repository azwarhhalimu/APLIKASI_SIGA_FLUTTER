import 'package:siga2/Admin_siga/Fragment/Admin_home.dart';
import 'package:siga2/Admin_siga/Fragment/Admin_presenting_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:siga2/Admin_siga/Input_data/Data_terpilah.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Pilih_tahun.dart';

class Dashboard extends StatefulWidget {
  static String routeName = "/admin_dashboard";
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int aktif_fragmen = 0;
  List fragmen = [
    Admin_home(),
    Admin_preseting_data(),
  ];

  void _pilihTahun(String id_tahun, String tahun) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return Data_terpilah(
          id_tahun: id_tahun,
          tahun: tahun,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: fragmen[aktif_fragmen],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            aktif_fragmen = value;
          });
        },
        currentIndex: aktif_fragmen,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(
            label: "Presenting Data",
            activeIcon: SvgPicture.asset("assets/icon/trend.svg",
                width: 25, height: 25, color: Colors.blue),
            icon: SvgPicture.asset(
              "assets/icon/trend.svg",
              width: 25,
              height: 25,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Pilih_tahun(callBack: _pilihTahun);
            },
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
