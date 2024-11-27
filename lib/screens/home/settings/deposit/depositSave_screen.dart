// ignore_for_file: file_names, avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:klizards/models/paymentMode_model.dart';
import 'package:klizards/utilities/api_manager.dart';
import 'package:klizards/utilities/app_constant.dart';
import 'package:klizards/utilities/helper_class.dart';
import 'package:klizards/widgets/common_widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DepositSaveScreen extends StatefulWidget {
  const DepositSaveScreen({super.key, required this.onOkPressed});
  final VoidCallback onOkPressed;

  @override
  State<DepositSaveScreen> createState() => _DepositSaveScreenState();
}

class _DepositSaveScreenState extends State<DepositSaveScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController paymentModeController = TextEditingController();
  File? galleryImage;
  List<PaymentDetail> paymentModeList = [];
  String dropdownValue = '';
  String modeSelectedID = '';

  @override
  void initState() {
    super.initState();
    serviceGetPaymentModeList();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => galleryImage = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void serviceSubmitDepositDetail() {
    context.loaderOverlay.show();

    Map<String, dynamic> param = {
      'amount': amountController.text,
      'payment_request_id': modeSelectedID,
    };

    ApiManager.sharedInstance.postRequestWithMedia(
      param: param,
      selectedImage: galleryImage!,
      url: Api.depositSave,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        showErrorAlertWithOkCallback(
            context, App().appName, "Detail Successfully added", () {
          widget.onOkPressed();
          Navigator.pop(context);
        });
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void serviceGetPaymentModeList() {
    context.loaderOverlay.show();

    ApiManager.sharedInstance.getRequest(
      url: Api.paymentModeList,
      completionCallback: () {
        context.loaderOverlay.hide();
      },
      successCallback: (responseBody) {
        var response = responseBody as Map<String, dynamic>;
        final data = response["data"] as Map<String, dynamic>;
        paymentModeList = PaymentModeModel.fromJson(data).list;
        setState(() {
          dropdownValue = paymentModeList.first.name;
          modeSelectedID = paymentModeList.first.id;
        });
      },
      failureCallback: (error) {
        showErrorAlert(context, App().appName, error);
      },
    );
  }

  void checkValidations() {
    if (galleryImage == null) {
      showErrorAlert(context, "Image", "Please select image");
    } else if (modeSelectedID.isEmpty) {
      showErrorAlert(context, "Payment mode", "Please select payment mode");
    } else if (amountController.text.isEmpty) {
      showErrorAlert(context, "Amount", "Please enter amount");
    } else {
      serviceSubmitDepositDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Deposit"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromARGB(255, 214, 214, 214),
                      image: galleryImage != null
                          ? DecorationImage(
                              image: FileImage(galleryImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: galleryImage == null
                        ? const Icon(
                            Icons.add,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                DropdownMenu<String>(
                    width: MediaQuery.of(context).size.width - 30,
                    initialSelection: dropdownValue,
                    label: Text(dropdownValue),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    onSelected: (String? value) {
                      setState(() {
                        List<String> parts = value!.split("-");
                        modeSelectedID = parts[0];
                        dropdownValue = parts[1];
                      });
                    },
                    dropdownMenuEntries: paymentModeList
                        .map<DropdownMenuEntry<String>>((PaymentDetail item) {
                      return DropdownMenuEntry<String>(
                          value: '${item.id}-${item.name}', label: item.name);
                    }).toList()),
                const SizedBox(
                  height: 20,
                ),
                textfieldCommonNew(
                    'Enter Amount', Icons.money, amountController),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: (() {
                      checkValidations();
                    }),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
