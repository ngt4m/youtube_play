class SearchModel {
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoId;
  final String channelTitle;

  SearchModel({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoId,
    required this.channelTitle,
  });

  factory SearchModel.fromMap(Map<String, dynamic> map) {
    return SearchModel(
      title: map['snippet']['title'],
      description: map['snippet']['description'],
      thumbnailUrl: map['snippet']['thumbnails']['default']['url'],
      videoId: map['id']['videoId'],
      channelTitle: map['snippet']['channelTitle'],
    );
  }
}
