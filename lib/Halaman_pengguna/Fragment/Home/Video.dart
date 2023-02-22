import 'dart:convert';

import 'package:siga2/Api_http/getVideo.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Componen/No_internet.dart';
import 'package:siga2/Halaman_pengguna/Fragment/Home/Lihat_video.dart';
import 'package:siga2/Shimmer/Shimmer_video.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  List data = [];
  _getVideo() {
    if (mounted)
      setState(() {
        isLoading = true;
      });
    getVideo().then((value) {
      if (mounted)
        setState(() {
          isLoading = false;
        });
      if (value == "terjadi_masalah") {
        Alert(context, "Opss", "Terjadi masalah pada internal server");
      } else if (value == "no_internet") {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return No_internet(click: _getVideo);
            }));
      } else {
        if (mounted)
          setState(() {
            data = jsonDecode(value)["data"];
          });
      }
    });
  }

  @override
  void initState() {
    _getVideo();
    // TODO: implement initState
    super.initState();
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer_video()
        : ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Video",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    for (int i = 0; i < data.length; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return Lihat_video(
                                id_video: data[i]["id_vidoe"],
                                judul: data[i]["judul"],
                              );
                            })));
                          },
                          trailing: Stack(
                            children: [
                              Container(
                                color: Colors.blue,
                                width: 70,
                                height: 70,
                                child: ImageNetwork(
                                    url: data[i]["url"], height_gambar: 70),
                              ),
                              Positioned(
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Icon(
                                    Icons.play_circle,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                                top: 12,
                                left: 20,
                              ),
                            ],
                          ),
                          contentPadding: EdgeInsets.all(0),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[i]["judul"],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                data[i]["tanggal"],
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                "Sumber : Youtube",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.black26),
                              ),
                            ],
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ],
          );
  }
}
