import 'package:siga2/Admin_siga/Dashbord.dart';
import 'package:siga2/Admin_siga/Login.dart';
import 'package:siga2/Admin_siga/Pengaturan/Ubah_username.dart';
import 'package:siga2/Admin_siga/SplashScreen.dart';
import 'package:siga2/Halaman_pengguna/Halaman_utama.dart';
import 'package:flutter/material.dart';
import 'package:siga2/SplashScreenMain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreenmain.routeName,
        theme: ThemeData(textTheme: TextTheme()),
        routes: {
          Halaman_utama.routeName: (context) => Halaman_utama(),
          SplashScreen.routeName: (context) => SplashScreen(),
          SplashScreenmain.routeName: (context) => SplashScreenmain(),
          Dashboard.routeName: (context) => Dashboard(),
          Login.routeName: (context) => Login(),
          Ubah_username.rounteName: (context) => Ubah_username()
        });
  }
}
