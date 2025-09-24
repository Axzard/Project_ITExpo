import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareUtils {
  static Future<void> shareGaleri(String path, String title) async {
    final file = File(path);
    if (await file.exists()) {
      await Share.shareFiles([file.path], text: 'Cek foto $title');
    } else {
      await Share.share('File tidak ditemukan: $title');
    }
  }
}
