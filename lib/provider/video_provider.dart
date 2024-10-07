import 'package:flutter_application_2/models/playlist_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_application_2/service/video_api.dart';

class VideoProvider {
  final YoutubePlayerController controller;
  final YouTubeService youtubeService;
  int currentIndex = 0;
  double currentvol = 100;
  List<PlaylistModel> queue = [];

  VideoProvider({
    required this.controller,
    required this.youtubeService,
  }) {
    // Listener khi video kết thúc
    controller.addListener(playVideoEnded);
  }

  void addVideoToQueue(PlaylistModel video) {
    queue.add(video);
    //   print('Video added to queue: ${video.title}');
  }

  // Hàm xử lý khi video kết thúc
  void playVideoEnded() {
    if (controller.value.playerState == PlayerState.ended) {
      playNextVideo();
    }
  }

  // Phát video tiếp theo
  void playNextVideo() {
    if (currentIndex < youtubeService.videos.length - 1) {
      currentIndex++;
      controller.load(youtubeService.videos[currentIndex].id);
    } else {
      print('No more videos in the playlist');
    }
  }


  // Dọn dẹp tài nguyên khi không sử dụng
  void dispose() {
    controller.dispose();
  }
}
