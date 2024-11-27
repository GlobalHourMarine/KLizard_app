// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/statement_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberInvestmentDetail extends StatefulWidget {
  final Function()? backCallback;
  final String cycleID;
  final String docPath;
  const MemberInvestmentDetail(
      {super.key,
      required this.cycleID,
      required this.docPath,
      this.backCallback});

  @override
  State<MemberInvestmentDetail> createState() => _MemberInvestmentDetailState();
}

class _MemberInvestmentDetailState extends State<MemberInvestmentDetail> {
  List<StatementDetail> statementList = [];

  @override
  void initState() {
    super.initState();
    serviceGetInvestmentDetail();
  }

  void serviceGetInvestmentDetail() {
    context.loaderOverlay.show();

    Map<String, String> params = {
      "investmentId": widget.cycleID,
      "return_type": "bonus",
    };

    ApiManager.sharedInstance.postRequest(
      url: Api.investmentDetailList,
      param: params,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        var statementDetail = StatementModel.fromJson(data);
        statementList = statementDetail.list;
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  // ignore: unused_element
  Future _launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  List<Map<String, String>> getCardData(StatementDetail detail) {
    return [
      {'title': 'Name : ', 'value': detail.name},
      {'title': 'Transaction ID : ', 'value': detail.transactionID},
      {'title': 'Investment Amount : ', 'value': detail.investmentAmount},
      {'title': 'Profit Percentage : ', 'value': detail.profitPercentage},
      {'title': 'From Account : ', 'value': detail.fromAccount},
      {'title': 'To Account : ', 'value': detail.toAccount},
      {'title': 'Credit Amount : ', 'value': detail.creditAmount},
      {'title': 'Credit Date : ', 'value': detail.profitCreditDate},
      {'title': 'Credit From : ', 'value': detail.creditFrom},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Member Cycle Detail"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: () {
                _launchURL(widget.docPath);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute<dynamic>(
                //     builder: (_) => PDFViewerFromUrl(
                //       url: widget.docPath,
                //     ),
                //   ),
                // );
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: statementList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                collapsedBackgroundColor:
                    const Color.fromARGB(255, 224, 208, 206),
                title: Text(
                  statementList[index].displayDate,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: Card(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: getDesignForListWithData(
                            getCardData(statementList[index]), false),
                      )))
                ],
              ),
            );
          },
        ));
  }
}
