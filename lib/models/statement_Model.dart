// ignore_for_file: file_names

class StatementModel {
  List<StatementDetail> list;
  List<InvestmentUpdatesDetail> updateList;
  String pdfLink;

  StatementModel({
    required this.list,
    required this.updateList,
    required this.pdfLink,
  });

  factory StatementModel.fromJson(Map<String, dynamic> json) {
    var pdfLink = json['excel_download_link'] as String;
    var statementList = json['list'] as List;
    var updateList = json['investment_updates'] as List;

    List<StatementDetail> statementDetail = statementList
        .map((detailJson) => StatementDetail.fromJson(detailJson))
        .toList();

    List<InvestmentUpdatesDetail> investmentUpdateDetails = updateList
        .map((detailJson) => InvestmentUpdatesDetail.fromJson(detailJson))
        .toList();

    return StatementModel(
        list: statementDetail,
        updateList: investmentUpdateDetails,
        pdfLink: pdfLink);
  }
}

class StatementDetail {
  String name;
  String investmentAmount;
  String profitPercentage;
  String fromAccount;
  String toAccount;
  String transactionID;
  String creditAmount;
  String profitCreditAmount;
  String profitCreditDate;

  String creditFrom;
  String displayDate;

  StatementDetail({
    required this.name,
    required this.investmentAmount,
    required this.profitPercentage,
    required this.fromAccount,
    required this.toAccount,
    required this.transactionID,
    required this.creditAmount,
    required this.profitCreditAmount,
    required this.profitCreditDate,
    required this.creditFrom,
    required this.displayDate,
  });

  factory StatementDetail.fromJson(Map<String, dynamic> json) {
    return StatementDetail(
      name: json['name'],
      investmentAmount: json['investment_amount'],
      profitPercentage: json['profit_percentage'],
      fromAccount: json['from_account'] ?? '',
      toAccount: json['to_account'] ?? '',
      transactionID: json['transaction_id'],
      creditAmount: json['credit_amount'],
      profitCreditAmount: json['profit_credit_amount'],
      creditFrom: json['credit_from'],
      displayDate: json['display_date'],
      profitCreditDate: json['profit_credit_date'],
    );
  }
}

class InvestmentUpdatesDetail {
  final String returnPercent;
  final String displayDate;
  final String amount;
  final String docPath;

  InvestmentUpdatesDetail({
    required this.returnPercent,
    required this.displayDate,
    required this.amount,
    required this.docPath,
  });

  factory InvestmentUpdatesDetail.fromJson(Map<String, dynamic> json) {
    return InvestmentUpdatesDetail(
      returnPercent: json['return'],
      displayDate: json['date'],
      amount: json['amount'],
      docPath: json['doc_path'],
    );
  }
}
