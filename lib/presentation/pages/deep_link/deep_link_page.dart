import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeepLinkPage extends StatefulWidget {
  const DeepLinkPage({super.key});

  @override
  State<DeepLinkPage> createState() => _DeepLinkPageState();
}

class _DeepLinkPageState extends State<DeepLinkPage> {
  final TextEditingController _traceIdController = TextEditingController(
    text: 'TEST123456',
  );

  Future<void> _testDeepLink() async {
    final traceId = _traceIdController.text.trim();
    if (traceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập traceId')),
      );
      return;
    }

    final uri = Uri.parse('https://app.easypos.vn/payment?traceid=$traceId');

    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Đã gọi deep link: $uri'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Không thể mở deep link'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lỗi: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Deep Link EasyPOS'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _traceIdController,
              decoration: const InputDecoration(
                labelText: 'Trace ID',
                hintText: 'Nhập traceId để test',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _testDeepLink,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
              ),
              child: const Text('Test Deep Link'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deep Link sẽ mở app EasyPOS',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              'URL: https://app.easypos.vn/payment?traceid={traceid}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _traceIdController.dispose();
    super.dispose();
  }
}