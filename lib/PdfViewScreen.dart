import 'package:flutter/material.dart';
import 'package:pdfrx/pdfrx.dart';

import 'QuestionaireScreen.dart';
import 'model/HivItem.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key, required this.pdf});

  final Hivitem pdf;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdf.fileName, overflow: TextOverflow.ellipsis),
      ),
      body: Stack(
        children: [
          PdfViewer.file(pdf.filePath),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Questionairescreen(pdf: pdf),
                  ),
                );
              },
              backgroundColor: const Color(0XFF1E88E5),
              icon: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 28),
              label: const Text(
                "Ask Gemini",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // @override
  // State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

// class _PdfViewerScreenState extends State<PdfViewerScreen> {
//   final TextEditingController _askController = TextEditingController();
//
//   @override
//   void dispose() {
//     _askController.dispose();
//     super.dispose();
//   }
//
//   void _ask(String question) {
//     final q = question.trim();
//     if (q.isEmpty) return;
//     FocusScope.of(context).unfocus();
//     _askController.clear();
//     // TODO: send q (and the PDF text) to Gemini and show the answer
//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('Asked: $q')));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.pdf.fileName, overflow: TextOverflow.ellipsis),
//       ),
//       body: Column(
//         children: [
//           Expanded(child: PdfViewer.file(widget.pdf.filePath)),
//           _AskBar(controller: _askController, onSubmit: _ask),
//         ],
//       ),
//     );
//   }
// }

