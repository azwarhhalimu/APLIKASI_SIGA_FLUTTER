import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:siga2/Api_http/getLihatVideo.dart';
import 'package:flutter/material.dart';
import 'package:siga2/Componen/AlertDialog.dart';
import 'package:siga2/Componen/ImageNetwork.dart';
import 'package:siga2/Config.dart';
import 'package:siga2/Shimmer/Shimmer_video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Lihat_video extends StatefulWidget {
  String id_video;
  String title;
  String id_youtube;
  Lihat_video(
      {super.key,
      required this.id_video,
      required this.title,
      required this.id_youtube});

  @override
  State<Lihat_video> createState() => _Lihat_videoState();
}

class _Lihat_videoState extends State<Lihat_video> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _ids = [];

  @override
  void initState() {
    _ids.add(widget.id_youtube);
    _getVideo();
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _ids.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  bool isLoading = false;
  List data = [];
  _getVideo() {
    setState(() {
      isLoading = true;
    });
    getLihatVideo(widget.id_video).then((value) {
      setState(() {
        isLoading = false;
      });
      if (value == "terjadi_masalah") {
        Alert(
            context, "Terjadi Masalah", "Terjadi kesalah pada internal server");
      } else if (value == "no_internet") {
        Alert(context, "No Internet",
                "Periksa kembali sambungan internet anda.")
            .then((value) => _getVideo());
      } else {
        setState(() {
          data = jsonDecode(value)["video_lainnya"];
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Color.fromRGBO(68, 138, 255, 1),
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              print('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller
              .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.black54,
              )),
          backgroundColor: Colors.white,
          title: const Text(
            '',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                Container(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            Expanded(
              child: isLoading
                  ? Shimmer_video()
                  : ListView(
                      children: [
                        for (int i = 0; i < data.length; i++)
                          Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Lihat_video(
                                          id_video: data[i]["id_video"],
                                          title: data[i]["judul"],
                                          id_youtube: data[i]["id_youtube"]);
                                    },
                                  ));
                                },
                                title: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data[i]["judul"],
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Image.asset(
                                        "assets/images/youtubelogo.png",
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                                trailing: Stack(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 66,
                                      child: ImageNetwork(
                                          url: data[i]["img"],
                                          height_gambar: 40),
                                    ),
                                    Positioned(
                                        top: 5,
                                        left: 18,
                                        child: Opacity(
                                          opacity: 0.7,
                                          child: Icon(
                                            Icons.play_circle,
                                            size: 30,
                                            color:
                                                Color.fromARGB(255, 242, 22, 7),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              Divider()
                            ],
                          )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _text(String title, String value) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: const TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }

  Widget get _space => const SizedBox(height: 10);

  Widget _loadCueButton(String action) {
    return Expanded(
      child: MaterialButton(
        color: Colors.blueAccent,
        onPressed: _isPlayerReady
            ? () {
                if (_idController.text.isNotEmpty) {
                  var id = YoutubePlayer.convertUrlToId(
                        _idController.text,
                      ) ??
                      '';
                  if (action == 'LOAD') _controller.load(id);
                  if (action == 'CUE') _controller.cue(id);
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  _showSnackBar('Source can\'t be empty!');
                }
              }
            : null,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
