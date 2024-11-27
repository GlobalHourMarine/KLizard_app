// ignore_for_file: file_names

class InvestmentModel {
  final String totalRecord;
  final List<InvestmentDetail> list;
  InvestmentModel({
    required this.totalRecord,
    required this.list,
  });

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    var investmentList = json['list'] as List;

    List<InvestmentDetail> investmentDetails = investmentList
        .map((detailJson) => InvestmentDetail.fromJson(detailJson))
        .toList();

    return InvestmentModel(
      totalRecord: json['totalRecord'],
      list: investmentDetails,
    );
  }
}

class InvestmentDetail {
  final String id;
  final String userId;
  final String amount;
  final String returnAmount;
  final String docPath;
  final String docPathDocument;

  final String startDate;
  final String returnDate;
  final String pdfName;

  InvestmentDetail({
    required this.id,
    required this.userId,
    required this.amount,
    required this.returnAmount,
    required this.docPath,
    required this.docPathDocument,
    required this.startDate,
    required this.returnDate,
    required this.pdfName,
  });

  factory InvestmentDetail.fromJson(Map<String, dynamic> json) {
    return InvestmentDetail(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'],
      returnAmount: json['return_amount'],
      docPath: json['doc_path'],
      docPathDocument: json['doc_path_documents'] ?? "",
      startDate: json['start_date'],
      returnDate: json['return_date'],
      pdfName: json['pdf_name'],
    );
  }
}
