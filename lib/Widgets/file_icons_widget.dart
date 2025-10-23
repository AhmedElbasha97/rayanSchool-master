import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class FileIconWidget extends StatelessWidget {
  final String fileName;

  const FileIconWidget({Key? key, required this.fileName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getFileIcon(fileName);
  }

  Widget _getFileIcon(String fileName) {
    final ext = p.extension(fileName).toLowerCase().replaceAll('.', '');
print(ext);
    final iconMap = {
      'pdf': 'PDF.png',
      'doc': 'DOC.png',
      'docx': 'DOCX.png',
      'xls': 'XSL.png',
      'xlsx': 'XSL.png',
      'ppt': 'PPT.png',
      'csv': 'CSV.png',
      'txt': 'TXT.png',
      'pub': 'PUB.png',
      'mdb': 'MDB.png',
      'zip': 'ZIP.png',
      'rar': 'ZIP.png',
      'jpg': 'JPG.png',
      'jpeg': 'JPG.png',
      'png': 'PNG.png',
      'gif': 'GIFF.png',
      'mp4': 'MP4.png',
      'mp3': 'MP3.png',
      'wav': 'WAV.png',
      'avi': 'AVI.png',
      'mov': 'MOV.png',
    };

    final iconName = iconMap[ext] ?? 'file.png'; // fallback icon
    final assetPath = 'assets/icons/$iconName';

    return Image.asset(
      assetPath,
      width: 48,
      height: 48,
      fit: BoxFit.contain,
    );
  }
}