// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/investment_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/utilities/pdf_screen.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentListScreen extends StatefulWidget {
  const DocumentListScreen({super.key});

  @override
  State<DocumentListScreen> createState() => _DocumentListScreenState();
}
//

class _DocumentListScreenState extends State<DocumentListScreen> {
  List<InvestmentDetail> investmentList = [];

  @override
  void initState() {
    super.initState();
    serviceGetInvestmentList();
  }

  Future launchURL(String urlString) async {
    Uri url = Uri.parse(urlString);
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  List<Map<String, String>> getCardData(InvestmentDetail detail) {
    return [
      {'title': 'PDF file : ', 'value': detail.pdfName},
    ];
  }

  String getPdfName(String pdfname) {
    List<String> parts = pdfname.split('/');
    String lastName = parts.last.replaceAll('.pdf', '');
    lastName = lastName.replaceAll('.pptx', '');
    return lastName;
  }

  void serviceGetInvestmentList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.investmentList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        investmentList = InvestmentModel.fromJson(data).list;
        setState(() {});
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Document List"),
      ),
      body: ListView.builder(
        itemCount: investmentList.length,
        itemBuilder: (context, index) {
          var detail = investmentList[index];
          return GestureDetector(
            onTap: () {
              launchURL(investmentList[index].docPathDocument);
              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromUrl(
                    url: investmentList[index].docPathDocument,
                    pdfName: investmentList[index].pdfName,
                  ),
                ),
              );
            },
            child: commonCardDesignForListWithData(getCardData(detail), true),
          );
        },
      ),
    );
  }
}
