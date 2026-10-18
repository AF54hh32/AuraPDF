import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import 'model/HivItem.dart';
import 'model/PdfItem.dart';


class PdfViewerScreen extends StatelessWidget {
  PdfViewerScreen({super.key, required this.pdf});

  Hivitem pdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdf.fileName, overflow: TextOverflow.ellipsis),
      ),
      body: PdfViewer.file(pdf.filePath),
    );
  }
}