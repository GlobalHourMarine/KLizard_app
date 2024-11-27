// ignore_for_file: file_names

class ReferralMemberModel {
  String id = '';
  String userId = '';
  String name = '';
  String address = '';
  String email = '';
  String designation = '';
  String createdAt = '';

  ReferralMemberModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.address,
    required this.email,
    required this.designation,
    required this.createdAt,
  });

  ReferralMemberModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
    designation = json['designation'];
    createdAt = json['created_at'];
  }
}
