import 'package:siga2/Admin_siga/Fragment/Admin_home.dart';
import 'package:siga2/Admin_siga/Fragment/Admin_presenting_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';

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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
