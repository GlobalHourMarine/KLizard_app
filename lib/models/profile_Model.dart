// ignore_for_file: file_names

class ProfileModel {
  final List<ProfileDetail> list;

  ProfileModel({
    required this.list,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    var detailList = json['profileData'] as List;
    List<ProfileDetail> profileDetail = detailList
        .map((detailJson) => ProfileDetail.fromJson(detailJson))
        .toList();

    return ProfileModel(
      list: profileDetail,
    );
  }
}

class ProfileDetail {
  final String key;
  final String value;

  ProfileDetail({
    required this.key,
    required this.value,
  });

  factory ProfileDetail.fromJson(Map<String, dynamic> json) {
    return ProfileDetail(
      key: json['key'],
      value: json['value'],
    );
  }
}
