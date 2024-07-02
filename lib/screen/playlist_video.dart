import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/models/video_model.dart';
import 'package:flutter_application_2/service/video_api.dart';

import 'package:flutter_application_2/screen/video.dart';
import 'package:provider/provider.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({Key? key}) : super(key: key);

  @override
  State<VideoListScreen> createState() => _VideoListState();
}

class _VideoListState extends State<VideoListScreen> {
  // List _items = [];
  // @override
  // void initState() {
  //   super.initState();
  //   readJson();
  // }
  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('assets/list_musi.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["items"];
  //   });
  //    }

  // bool _isLoading = true;
  //List<ListVideoModel>? _videos;

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final videoProvider = Provider.of<YouTubeService>(context, listen: false);
    videoProvider.fetchVideosByPlaylistId();
    scrollController.addListener(() {
      //listener scroll to bottom -> load more video
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !videoProvider.isLoading) {
        videoProvider.fetchVideosByPlaylistId();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  // _fetchVideos() async {
  //   YouTubeService youtubeService = YouTubeService();
  //   try {
  //     List<ListVideo> videos = await youtubeService.fetchVideosByPlaylistId();
  //     setState(() {
  //       _videos = videos;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print(e);
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromARGB(255, 22, 22, 22),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    Text(
                      'Playlists',
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      'Recently Played',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w800),
                    ),
                    Spacer(),
                    Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Consumer<YouTubeService>(
              builder: (context, videoProvider, child) {
                //playlist is empty or loading
                if (videoProvider.isLoading && videoProvider.videos.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  // playlist length
                  itemCount: videoProvider.videos.length +
                      (videoProvider.isLoading ? 1 : 0),

                  itemBuilder: (context, index) {
                 if (index == videoProvider.videos.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                    final ListVideoModel video = videoProvider.videos[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          
                          MaterialPageRoute(
                            builder: (context) => VideoScreen(
                              youtubeID: video.id,
                              youtubeTitle: video.title,
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        leading: Image.network(video.thumbnailUrl),
                        title: Text(
                          video.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(video.channelTitle),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
