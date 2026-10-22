import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:aura_pdf/DioClient.dart';

class Apirequest {

  Uint8List pdfBytes;

  String question;

  Apirequest({required this.pdfBytes,
    required this.question });

  Future<String> askAboutPdf() async {
       // Step 1: Upload the PDF File (Resumable Upload)
       final uploadInitResponse = await DioClient.instance.post(
            'https://generativelanguage.googleapis.com/upload/v1beta/files',
            options: Options(
              headers: {
                'X-Goog-Upload-Protocol': 'resumable',
                'X-Goog-Upload-Command': 'start',
                'X-Goog-Upload-Header-Content-Length': pdfBytes.length.toString(),
                'X-Goog-Upload-Header-Content-Type': 'application/pdf',
              },
            ),
            data: jsonEncode({
              'file': {'display_name': 'document.pdf'}
            }),
       );

       final uploadUrl = uploadInitResponse.headers.value('x-goog-upload-url');
       if (uploadUrl == null) {
         throw Exception('Failed to obtain upload URL from Gemini API.');
       }

       final uploadResponse = await DioClient.instance.post(
            uploadUrl,
            options: Options(
              headers: {
                'Content-Length': pdfBytes.length.toString(),
                'X-Goog-Upload-Offset': '0',
                'X-Goog-Upload-Command': 'upload, finalize',
              },
              contentType: 'application/pdf',
            ),
            data: pdfBytes,
       );

       final fileUri = uploadResponse.data['file']['uri'] as String;

       // Step 2: Ask Questions
       final response = await DioClient.instance.post(
            '/models/gemini-3.5-flash:generateContent',
            data: {
             'contents': [
            {
              'parts': [
                      {
                        'fileData': {
                          'mimeType': 'application/pdf',
                          'fileUri': fileUri,
                        },
                      },
                      {
                        'text': question
                      },
              ],
            },
             ],
           },
       );

       final text = response.data['candidates']?[0]?['content']?['parts']?[0]?['text'];

       return text as String? ?? 'No answer returned.';
  }

}