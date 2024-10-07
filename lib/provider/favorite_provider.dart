import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/playlist_model.dart';
import 'package:flutter_application_2/models/search_model.dart';
import 'package:flutter_application_2/models/video_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<VideoModel> listFavorite = [];
  List<VideoModel> get favoritePlay => listFavorite;

  void AddFavoriteFromList(PlaylistModel playlist) {
    final videoModel = VideoModel.fromPlaylist(playlist);
    if (!listFavorite.contains(videoModel)) {}
    listFavorite.add(videoModel);
    notifyListeners();
  }

  void AddFavoriteFromSearch(SearchModel search) {
    final searchModel = VideoModel.fromSearch(search);
    if (!listFavorite.contains(searchModel)) {
      listFavorite.add(searchModel);
      notifyListeners();
    }
  }

  void removeVideo(VideoModel video) {
    if (listFavorite.contains(video)) {
      listFavorite.remove(video);
      notifyListeners();
    }
  }

  void clearAll() {
    listFavorite.clear();
    notifyListeners();
  }
}
