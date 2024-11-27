// ignore_for_file: file_names, non_constant_identifier_names

class DepositModel {
  final int totalRecord;
  final List<DepositDetail> list;

  DepositModel({
    required this.totalRecord,
    required this.list,
  });

  factory DepositModel.fromJson(Map<String, dynamic> json) {
    var depositList = json['list'] as List;
    List<DepositDetail> depositDetails = depositList
        .map((detailJson) => DepositDetail.fromJson(detailJson))
        .toList();

    return DepositModel(
      totalRecord: json['totalRecord'],
      list: depositDetails,
    );
  }
}

class DepositDetail {
  final String id;
  final String user_id;
  final String payment_request_id;
  final String amount;
  final String status;
  final String image_path;
  final String name;
  final String text_data;
  final String createdAt;

  DepositDetail({
    required this.id,
    required this.user_id,
    required this.payment_request_id,
    required this.amount,
    required this.status,
    required this.image_path,
    required this.name,
    required this.text_data,
    required this.createdAt,
  });

  factory DepositDetail.fromJson(Map<String, dynamic> json) {
    return DepositDetail(
      id: json['id'],
      user_id: json['user_id'] ?? "",
      payment_request_id: json['payment_request_id'] ?? "",
      amount: json['amount'] ?? "",
      status: json['status'] ?? "",
      image_path: json['image_path'] ?? "",
      name: json['name'] ?? "",
      text_data: json['text_data'] ?? "",
      createdAt: json['createdAt'] ?? "",
    );
  }
}
