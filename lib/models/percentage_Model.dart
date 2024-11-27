// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: camel_case_types, file_names

class PercentageModel {
  String? id;
  String? amount;
  String? percent;
  String? createdAt;

  PercentageModel({this.id, this.amount, this.percent, this.createdAt});

  PercentageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    percent = json['percent'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['percent'] = percent;
    data['created_at'] = createdAt;
    return data;
  }
}
