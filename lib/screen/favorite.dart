import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/video_model.dart';
import 'package:flutter_application_2/provider/favorite_provider.dart';
import 'package:flutter_application_2/screen/video.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late FavoriteProvider videoManager;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Consumer<FavoriteProvider>(
          builder: (context, favorite, child) {
            if (favorite.favoritePlay.isEmpty) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
              itemCount: favorite.favoritePlay.length,
              itemBuilder: (context, index) {
                final VideoModel video = favorite.favoritePlay[index];
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
