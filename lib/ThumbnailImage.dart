

import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfrx/pdfrx.dart';

class Thumbnailimage {

  static Future<File?> getThumbnailImage(String filePath,{double width = 300}) async {

    final cacheDir = Directory('${(await getTemporaryDirectory()).path}/thumbs');
    if (!await cacheDir.exists()) await cacheDir.create(recursive: true);

    // Cache key: changes if the file changes
    final stat = File(filePath).statSync();
    final safeName = filePath.split('/').last.replaceAll(RegExp(r'[^A-Za-z0-9]'), '_');
    final out = File(
      '${cacheDir.path}/${safeName}_${stat.size}_${stat.modified.millisecondsSinceEpoch}.png',
    );
    if (await out.exists()) return out;

    PdfDocument? document;
    try {
      document = await PdfDocument.openFile(filePath);
      final page = document.pages.first;

      final scale = width / page.width;
      final pageImage = await page.render(
        fullWidth: width,
        fullHeight: page.height * scale,
      );
      if (pageImage == null) return null;

      final ui.Image image = await pageImage.createImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      pageImage.dispose();
      image.dispose();
      if (byteData == null) return null;

      await out.writeAsBytes(byteData.buffer.asUint8List());
      return out;
    } catch (e) {
      debugPrint('Thumbnail error: $e');
      return null;
    } finally {
      document?.dispose();
    }



  }




}