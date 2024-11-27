// ignore_for_file: file_names

class BannerModel {
  final int totalRecord;
  final List<BannerDetail> list;

  BannerModel({
    required this.totalRecord,
    required this.list,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    var feedList = json['list'] as List;
    List<BannerDetail> bannerDetails = feedList
        .map((detailJson) => BannerDetail.fromJson(detailJson))
        .toList();

    return BannerModel(
      totalRecord: json['totalRecord'],
      list: bannerDetails,
    );
  }
}

class BannerDetail {
  final String id;
  final String caption;
  final String type;
  final String path;

  BannerDetail({
    required this.id,
    required this.caption,
    required this.type,
    required this.path,
  });

  factory BannerDetail.fromJson(Map<String, dynamic> json) {
    return BannerDetail(
      id: json['id'],
      caption: json['banner_caption'],
      type: json['banner_type'],
      path: json['path'],
    );
  }
}
