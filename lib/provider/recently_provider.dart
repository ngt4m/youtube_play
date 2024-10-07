import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/search_model.dart';
import 'package:flutter_application_2/models/playlist_model.dart';
import 'package:flutter_application_2/models/video_model.dart';

class RecentlyProvider extends ChangeNotifier {
  final List<VideoModel> listRecently = [];
  List<VideoModel> get recentlyPlayed => listRecently;

  // void addVideoFromPlaylist(PlaylistModel video) {
  //   if (!listRecently.contains(video)) {
  //     listRecently.add(video);
  //     notifyListeners();
  //   }
  // }
  void addVideoFromPlaylist(PlaylistModel video) {
    final videoModel = VideoModel.fromPlaylist(video);
    if (!listRecently.contains(videoModel)) {
      listRecently.add(videoModel);
      notifyListeners();
    }
  }

  void addVideoFromSearch(SearchModel search) {
    final searchModel = VideoModel.fromSearch(search);
    if (!listRecently.contains(searchModel)) {
      listRecently.add(searchModel);
      notifyListeners();
    }
  }

  void removeVideo(PlaylistModel video) {
    if (listRecently.contains(video)) {
      listRecently.remove(video);
      notifyListeners();
    }
  }

  void clearAll() {
    listRecently.clear();
    notifyListeners();
  }
}
