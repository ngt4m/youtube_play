import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/search_model.dart';
import 'package:flutter_application_2/screen/video.dart';
import 'package:flutter_application_2/service/video_api.dart';
import 'package:provider/provider.dart';

class SearchVideo extends StatefulWidget {
  const SearchVideo({Key? key}) : super(key: key);

  @override
  _SearchVideoState createState() => _SearchVideoState();
}

class _SearchVideoState extends State<SearchVideo> {
  bool typing = false;
  List<SearchModel> result = [];

  // YouTubeService youtubeService = YouTubeService();
  // Future<void> callAPI() async {
  //   if (TextBox.ytsearch.text.isNotEmpty) {
  //     result =await youtubeService.searchVideos(TextBox.ytsearch.text);
  //     setState(() {});
  //   }
  // }

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
//listener scroll to bottom -> load more video
    scrollController.addListener(() {
      final videoProvider = Provider.of<YouTubeService>(context, listen: false);
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !videoProvider.isLoading) {
        videoProvider.searchVideos(TextBox.ytsearch.text,
            loadMore: true); //search more video
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _searchVideos() {
    final videoProvider = Provider.of<YouTubeService>(context, listen: false);
    videoProvider.searchVideos(TextBox.ytsearch.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextBox(),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                if (!typing) {
                  //có chữ thì tìm kiếm kết quả
                  _searchVideos();
                }
              });
            },
          ),
        ],
      ),
      body: Consumer<YouTubeService>(
        builder: (context, videoProvider, child) {
          if (videoProvider.isLoading && videoProvider.search.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              controller: scrollController,
              itemCount: videoProvider.search.length +
                  (videoProvider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == videoProvider.search.length) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final SearchModel searchVideo = videoProvider.search[index];
                return listItem(searchVideo, context);
              });
        },
      ),
    );
  }
}

Widget listItem(SearchModel video, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        //-> video screen
        MaterialPageRoute(
          builder: (context) =>
              VideoScreen(youtubeID: video.videoId, youtubeTitle: video.title),
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
}

class TextBox extends StatelessWidget {
  const TextBox({Key? key}) : super(key: key);
  static TextEditingController ytsearch = TextEditingController();
  void _clearTextField() {
    ytsearch.clear();
  }

//search box
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 129, 129, 129),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _clearTextField();
            },
          ),
        ),
        controller: ytsearch,
        //tap Enter
        onSubmitted: (value) {
          final videoProvider =
              Provider.of<YouTubeService>(context, listen: false);
          videoProvider.searchVideos(value);
        },
      ),
    );
  }
}
