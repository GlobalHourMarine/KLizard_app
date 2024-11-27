// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:klizards/models/ppt_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/utilities/pdf_screen.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class PptListScreen extends StatefulWidget {
  const PptListScreen({super.key});

  @override
  State<PptListScreen> createState() => _PptListScreenState();
}
//

class _PptListScreenState extends State<PptListScreen> {
  List<PptModel> pptList = [];

  @override
  void initState() {
    super.initState();
    serviceGetPptList();
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

  List<Map<String, String>> getCardData(PptModel detail) {
    return [
      {'title': detail.title, 'value': ''},
    ];
  }

  void serviceGetPptList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.pptList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final listData = response["data"] as List<dynamic>;
        pptList.clear();
        pptList
            .addAll(listData.map((e) => PptModel(e["title"], e["ppt_link"])));
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
        title: const Text("PDFs"),
      ),
      body: ListView.builder(
        itemCount: pptList.length,
        itemBuilder: (context, index) {
          var detail = pptList[index];
          return GestureDetector(
            onTap: () {
              // launchURL(pptList[index].link);

              Navigator.push(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (_) => PDFViewerFromUrl(
                    url: detail.link,
                    pdfName: '',
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
