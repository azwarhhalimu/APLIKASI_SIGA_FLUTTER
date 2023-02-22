import 'package:flutter/material.dart';

class Shimmer_lihat_semua_tahun extends StatelessWidget {
  const Shimmer_lihat_semua_tahun({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      strokeWidth: 10,
                    ),
                    Text("Loading")
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.black12),
                );
              })),
        )
      ],
    );
  }
}
