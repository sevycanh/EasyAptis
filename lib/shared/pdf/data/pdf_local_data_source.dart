import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

abstract class PdfLocalDataSource {
  // Future<String> getCachedPdf(String id, String url);

  Future<String> getLocalPdf(String assetPath, String fileName);
}

class PdfLocalDataSourceImpl implements PdfLocalDataSource {
  static const Duration cacheDuration = Duration(days: 30);

  // @override
  // Future<String> getCachedPdf(String id, String url) async {
  //   final dir = await getApplicationDocumentsDirectory();
  //   final filePath = '${dir.path}/$id.pdf';
  //   final file = File(filePath);

  //   if (await file.exists()) {
  //     final lastModified = await file.lastModified();
  //     final now = DateTime.now();
  //     if (now.difference(lastModified) < cacheDuration) {
  //       return filePath; 
  //     }
  //   }

  //   final response = await http.get(Uri.parse(url));
  //   if (response.statusCode == 200) {
  //     await file.writeAsBytes(response.bodyBytes, flush: true);
  //     return filePath;
  //   } else {
  //     throw Exception("Không tải được PDF");
  //   }
  // }

  @override
  Future<String> getLocalPdf(String assetPath, String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$fileName');

    if (await file.exists()) {
      return file.path;
    }

    // Copy từ assets
    final byteData = await rootBundle.load(assetPath);
    await file.writeAsBytes(
      byteData.buffer.asUint8List(),
      flush: true,
    );

    return file.path;
  }
}
