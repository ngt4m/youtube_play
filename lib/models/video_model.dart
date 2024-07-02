class ListVideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  ListVideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory ListVideoModel.fromMap(Map<String, dynamic> map) {
    return ListVideoModel(
      id: map['id'],
      title: map['snippet']['title'],
      thumbnailUrl: map['snippet']['thumbnails']['default']['url'],
      channelTitle: map['snippet']['channelTitle'],
    );
  }
}
