// ignore_for_file: file_names

class PaymentModeModel {
  final int totalRecord;
  final List<PaymentDetail> list;

  PaymentModeModel({
    required this.totalRecord,
    required this.list,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) {
    var investmentList = json['list'] as List;
    List<PaymentDetail> investmentDetails = investmentList
        .map((detailJson) => PaymentDetail.fromJson(detailJson))
        .toList();

    return PaymentModeModel(
      totalRecord: json['totalRecord'],
      list: investmentDetails,
    );
  }
}

class PaymentDetail {
  final String id;
  final String name;
  final String textData;
  final String imagePath;

  PaymentDetail({
    required this.id,
    required this.name,
    required this.textData,
    required this.imagePath,
  });

  factory PaymentDetail.fromJson(Map<String, dynamic> json) {
    return PaymentDetail(
      id: json['id'],
      name: json['name'] ?? "",
      textData: json['text_data'] ?? "",
      imagePath: json['image_path'] ?? "",
    );
  }
}
