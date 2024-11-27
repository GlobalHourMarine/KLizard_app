import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:klizards/models/statement_Model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/listCard_widget.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class StatementScreen extends StatefulWidget {
  final Function()? backCallback;
  final String cycleID;
  final String docPath;
  const StatementScreen(
      {super.key,
      required this.cycleID,
      required this.docPath,
      this.backCallback});

  @override
  State<StatementScreen> createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> {
  List<StatementDetail> statementList = [];
  List<InvestmentUpdatesDetail> updateList = [];

  int tabCurrentIndex = 0;

  @override
  void initState() {
    super.initState();
    serviceGetInvestmentDetail();
  }

  void serviceGetInvestmentDetail() {
    context.loaderOverlay.show();

    Map<String, String> params = {
      "investmentId": widget.cycleID,
      "return_type": "main",
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
        updateList = statementDetail.updateList;
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

  List<Map<String, String>> getCardData(dynamic detail) {
    if (tabCurrentIndex == 0) {
      return [
        {'title': 'Investment Amount : ', 'value': detail.amount},
        {'title': 'Profit Percentage : ', 'value': detail.returnPercent},
        // {'title': 'Date : ', 'value': detail.date},
      ];
    } else {
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
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          widget.backCallback?.call();
          // Navigator.of(context).pop();
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  widget.backCallback?.call();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              title: const Text("Cycle Detail"),
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
            body: Column(
              children: [
                const SizedBox(
                  height: 2,
                ),
                FlutterToggleTab(
                  borderRadius: 0,
                  selectedIndex: tabCurrentIndex,
                  selectedTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  unSelectedTextStyle: const TextStyle(
                      color: AppColors.colorGradientLightMehroon,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  selectedBackgroundColors: const [
                    AppColors.colorGradientLightMehroon
                  ],
                  unSelectedBackgroundColors: const [
                    Color.fromARGB(255, 241, 240, 240)
                  ],
                  labels: const ["Deposit", "Return"],
                  selectedLabelIndex: (index) {
                    tabCurrentIndex = index;
                    setState(() {});
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tabCurrentIndex == 0
                        ? updateList.length
                        : statementList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              const Color.fromARGB(255, 224, 208, 206),
                          title: Text(
                            tabCurrentIndex == 0
                                ? updateList[index].displayDate
                                : statementList[index].displayDate,
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
                                      getCardData(tabCurrentIndex == 0
                                          ? updateList[index]
                                          : statementList[index]),
                                      false),
                                )))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}
