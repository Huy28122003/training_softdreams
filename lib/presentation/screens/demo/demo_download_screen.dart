import 'dart:io';

import 'package:flutter/material.dart';

import '../../../di/locator.dart';
import '../../../domain/usecases/download/cancel_download.dart';
import '../../../domain/usecases/download/download_file.dart';
import '../../../utils/file.dart';

class DemoDownloadScreen extends StatefulWidget {
  const DemoDownloadScreen({super.key});

  @override
  State<DemoDownloadScreen> createState() => _DemoDownloadScreenState();
}

class _DemoDownloadScreenState extends State<DemoDownloadScreen> {
  late final DownloadFile _downloadFile;
  late final CancelDownload _cancelDownload;
  String _outputDir = '';

  String message = 'Press the download button to start the download';
  bool downloaded = false;
  double value = 0.0;

  @override
  void initState() {
    super.initState();
    _downloadFile = locator<DownloadFile>();
    _cancelDownload = locator<CancelDownload>();
  }

  Future<void> _startDownload(List<String> urls) async {
    _outputDir = await FileUtils().getAppDirPath();

    value = 0.0;
    final result = await _downloadFile(DownloadFileParams(
      urls: urls,
      outputDir: _outputDir,
      onProgress: (progressValue) {
        downloaded = false;
        value = progressValue;
        setState(() {
          downloaded = progressValue >= 100.0;
          message = 'Downloading - ${progressValue.toStringAsFixed(2)}';
          print(message);

          if (downloaded) {
            message = 'Download completed';
          }
        });
      },
      onCancel: () {
        message = 'Cancelled by user';
        setState(() {});
      },
    ));

    result.fold(
      (l) {
        setState(() {
          downloaded = false;
          message = 'Error: ${l.message}';
        });
      },
      (r) => null,
    );
  }

  Future<void> _cancel(List<String> urls) async {
    print('cancel download');
    await _cancelDownload(urls);
  }

  @override
  Widget build(BuildContext context) {
    final urls = [
      'https://github.com/edjostenes/download_assets/raw/main/download/image_1.png',
      'https://github.com/edjostenes/download_assets/raw/main/download/assets.zip',
      'https://github.com/edjostenes/download_assets/raw/main/download/image_2.png',
      'https://github.com/edjostenes/download_assets/raw/main/download/image_3.png',
      'https://dmv-roadready.cloud/uploads/traffic_sign.zip',
    ];

    return Scaffold(
      appBar: AppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message),
              if (downloaded && _outputDir.isNotEmpty) ...[
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File('$_outputDir/image_1.png')),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File('$_outputDir/dart.jpeg')),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File('$_outputDir/--D11-1a--.png')),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => _startDownload(urls),
            tooltip: 'Download',
            child: const Icon(Icons.arrow_downward),
          ),
          const SizedBox(
            width: 25,
          ),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () => _cancel(urls),
            tooltip: 'Cancel',
            child: const Icon(Icons.cancel_outlined),
          ),
        ],
      ),
    );
  }
}
