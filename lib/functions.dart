import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void downloadAsset(
    {required String url,
    required String filename,
    required void Function(int, int)? onReceiveProgress,
    required Function callWhenFileDownload,
    required Function callWhenFileDownloaded}) async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  String path = '$dir/$filename';
  if (!await File(path).exists()) {
    callWhenFileDownload();
    Dio dio = Dio();
    await dio.download(
      url,
      path,
      onReceiveProgress: onReceiveProgress,
    );
  }
  callWhenFileDownloaded();
  // var bytes = await consolidateHttpClientResponseBytes(response);
  // //String dir = (await getApplicationDocumentsDirectory()).path;
  // File file = File('$dir/$filename');
  // await file.writeAsBytes(bytes);
  debugPrint("Downloading finished, path: " '$dir/$filename');
}
