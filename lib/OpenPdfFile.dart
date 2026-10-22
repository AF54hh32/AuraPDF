import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file/open_file.dart';

import 'model/PdfItem.dart';

class Openpdffile {
  static Future<List<PdfItem>> openPdf() async {
    try {
      final List<PlatformFile> file = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      List<PdfItem> pdf_new = [];


      for(var f in file){
        pdf_new.add(PdfItem(f.name, f.path!));
      }

      return pdf_new;

      //return file;
      // if (file != null && file.path != null) {
      //   final result = await OpenFile.open(file.path!);
      //   if (result.type != ResultType.done) {
      //     debugPrint("OpenFile error: ${result.message}");
      //   }
      // }
    } catch (e) {
      debugPrint("OpenPdfFile exception: $e");
      return [];
    }
  }

}