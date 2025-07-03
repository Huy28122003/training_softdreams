import 'package:flutter/material.dart';

import '../../../di/locator.dart';
import '../../../domain/usecases/sync/sync_post_data.dart';
import '../demo/demo_connectivity_screen.dart';
import '../demo/demo_dialog_screen.dart';
import '../demo/demo_download_screen.dart';
import '../demo/demo_page_route_screen.dart';
import '../post/post_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PostScreen(),
                  ),
                );
              },
              child: const Text('Posts'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoDialogScreen(),
                  ),
                );
              },
              child: const Text('Demo dialog'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoPageRouteScreen(),
                  ),
                );
              },
              child: const Text('Demo page'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoConnectivityScreen(),
                  ),
                );
              },
              child: const Text('Demo network'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DemoDownloadScreen(),
                  ),
                );
              },
              child: const Text('Demo download'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                locator<SyncPostData>()();
              },
              child: const Text('Demo sync data'),
            ),
          ],
        ),
      ),
    );
  }
}
