class SearchModel {
  final String title;
  final String thumbnailUrl;
  final String id;
  final String channelTitle;

  SearchModel({
    required this.title,
    required this.thumbnailUrl,
    required this.id,
    required this.channelTitle,
  });

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['default']['url'],
      id: map['id']['videoId'],
      channelTitle: map['snippet']['channelTitle'],
    );
  }
}
