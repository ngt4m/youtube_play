import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class BottomSheetPlayer extends StatelessWidget {
  final YoutubePlayerController controller;
  final String title;
  BottomSheetPlayer({required this.controller,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 100,
      child: Column(
        children: [
      Text(title,style: TextStyle(color: Colors.white),),
        ],
      ),
    );
  }
}
