import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/video_model.dart';
import 'package:flutter_application_2/provider/recently_provider.dart';
import 'package:flutter_application_2/provider/video_provider.dart';
import 'package:flutter_application_2/screen/video.dart';
import 'package:provider/provider.dart';

class RecentlyPlay extends StatefulWidget {
  const RecentlyPlay({Key? key}) : super(key: key);

  @override
  _RecentlyPlayState createState() => _RecentlyPlayState();
}

class _RecentlyPlayState extends State<RecentlyPlay> {
  late VideoProvider videoManager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<RecentlyProvider>(
          builder: (context, recentlyProvider, child) {
         
            if (recentlyProvider.recentlyPlayed.isEmpty) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: -recentlyProvider.recentlyPlayed.length,
              itemBuilder: (context, index) {
                final VideoModel video = recentlyProvider.recentlyPlayed[index];
                return ListTile(
                  leading: Image.network(video.thumbnailUrl),
                  title: Text(
                    video.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(video.channelTitle),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoScreen(
                            youtubeID: video.id, youtubeTitle: video.title),
                      ),
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
