import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({super.key, required this.url, required this.pdfName});

  final String url;
  final String pdfName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getPdfName()),
      ),
      body: const PDF().fromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }

  String getPdfName() {
    List<String> parts = url.split('/');
    String lastName = parts.last.replaceAll('.pdf', '');
    lastName = lastName.replaceAll('.pptx', '');
    return lastName;
  }
}
