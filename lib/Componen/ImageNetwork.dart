import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatefulWidget {
  String url;
  double height_gambar;
  ImageNetwork({super.key, required this.url, required this.height_gambar});

  @override
  State<ImageNetwork> createState() => _ImageNetworkState();
}

class _ImageNetworkState extends State<ImageNetwork> {
  @override
  Widget build(BuildContext context) {
    return widget.url == ""
        ? Container(
            width: double.infinity,
            height: widget.height_gambar,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 243, 243),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.image,
              size: widget.height_gambar / 2,
            ),
          )
        : CachedNetworkImage(
            fit: BoxFit.cover,
            width: double.infinity,
            imageUrl: widget.url,
            placeholder: (context, url) => Center(
              child: Text(
                "Loading",
                style: TextStyle(fontSize: 10),
              ),
            ),
          );
  }
}
