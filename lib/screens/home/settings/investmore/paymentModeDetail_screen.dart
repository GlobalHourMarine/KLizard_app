// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:klizards/models/paymentMode_model.dart';
import 'package:klizards/utilities/app_constant.dart';

class PaymentModeDetailScreen extends StatefulWidget {
  final PaymentDetail paymentDetail;

  const PaymentModeDetailScreen({super.key, required this.paymentDetail});

  @override
  State<PaymentModeDetailScreen> createState() =>
      _PaymentModeDetailScreenState();
}

class _PaymentModeDetailScreenState extends State<PaymentModeDetailScreen> {
  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.paymentDetail.textData));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('UPI copied to clipboard'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.paymentDetail.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.network(
                  fit: BoxFit.cover,
                  widget.paymentDetail.imagePath,
                  width: MediaQuery.of(context).size.width,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    // Error occurred while loading the image
                    return Container(
                      width: 250.0,
                      height: 250.0,
                      color: Colors.grey,
                      child: const Center(
                        child: Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'UPI ID: ${widget.paymentDetail.textData}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    copyToClipboard();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(AppColors.themeColor),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        side: const BorderSide(
                          color: AppColors.themeColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(80.0, 40.0),
                    ),
                  ),
                  child: const Text(
                    'Copy UPI ID',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
