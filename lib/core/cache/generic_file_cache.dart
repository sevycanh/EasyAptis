import 'dart:io';
import 'package:easyaptis/core/configs/constants/app_constant.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class GenericFileCache {
  final String folderName;
  final Duration expireAfter;

  GenericFileCache({
    required this.folderName,
    this.expireAfter = const Duration(
      days: AppConstants.DURATION_DATE_SAVE_DATA_LIMIT,
    ),
  });

  Future<Directory> _getCacheDir() async {
    final tmp = await getTemporaryDirectory();
    final dir = Directory('${tmp.path}/$folderName');
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  String _fileNameFromUrl(String url) => url.hashCode.toString();

  Future<File?> getFileIfValid(String url) async {
    final dir = await _getCacheDir();
    final file = File('${dir.path}/${_fileNameFromUrl(url)}');
    if (!await file.exists()) return null;
    final stat = await file.stat();
    if (DateTime.now().difference(stat.modified) > expireAfter) {
      try {
        await file.delete();
      } catch (_) {}
      return null;
    }
    return file;
  }

  Future<File> downloadAndCache(String url) async {
    final dir = await _getCacheDir();
    final file = File('${dir.path}/${_fileNameFromUrl(url)}');

    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw Exception('Failed to download file: ${res.statusCode}');
    }
    await file.writeAsBytes(res.bodyBytes, flush: true);
    return file;
  }

  Future<File> getOrDownload(String url) async {
    final existing = await getFileIfValid(url);
    if (existing != null) return existing;
    return await downloadAndCache(url);
  }

  Future<void> clearAll() async {
    final dir = await _getCacheDir();
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }
}
