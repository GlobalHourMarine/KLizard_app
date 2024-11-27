// ignore_for_file: file_names

class FeedModel {
  final String totalRecord;
  final List<FeedDetail> list;

  FeedModel({
    required this.totalRecord,
    required this.list,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    var feedList = json['list'] as List;
    List<FeedDetail> feedDetails =
        feedList.map((detailJson) => FeedDetail.fromJson(detailJson)).toList();

    return FeedModel(
      totalRecord: json['totalRecord'],
      list: feedDetails,
    );
  }
}

class FeedDetail {
  final String id;
  final String videoLink;
  final String title;
  final String createdAt;
  String thumbnailUrl; // Add thumbnailUrl property

  FeedDetail({
    required this.id,
    required this.videoLink,
    required this.title,
    required this.createdAt,
    this.thumbnailUrl = "", // Initialize thumbnailUrl with empty string
  });

  factory FeedDetail.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] ?? "";
    final String videoLink = json['video_link'] ?? "";
    final String title = json['title'] ?? "Title is not available";
    final String createdAt = json['created_at'] ?? "";

    final String thumbnailUrl = extractThumbnailUrl(videoLink);

    return FeedDetail(
      id: id,
      videoLink: videoLink,
      title: title,
      createdAt: createdAt,
      thumbnailUrl: thumbnailUrl,
    );
  }

  static String extractThumbnailUrl(String videoLink) {
    final RegExp regExp = RegExp(r"youtube\.com\/watch\?v=([a-zA-Z0-9_-]+)");
    final Match? match = regExp.firstMatch(videoLink);
    if (match != null && match.groupCount >= 1) {
      final String videoId = match.group(1)!;
      return "https://img.youtube.com/vi/$videoId/mqdefault.jpg";
    }
    return ""; // Return empty string if video link is invalid
  }
}
