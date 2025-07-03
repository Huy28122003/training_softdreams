import 'package:flutter/material.dart';

import '../../widgets/dialogs/animated_dialog.dart';

class DemoDialogScreen extends StatefulWidget {
  const DemoDialogScreen({super.key});

  @override
  State<DemoDialogScreen> createState() => _DemoDialogScreenState();
}

class _DemoDialogScreenState extends State<DemoDialogScreen> {
  DialogTransitionType _animationType = DialogTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton<DialogTransitionType>(
              value: _animationType,
              items: DialogTransitionType.values
                  .map<DropdownMenuItem<DialogTransitionType>>(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _animationType = value ?? DialogTransitionType.none;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                showAnimatedDialog(
                  context: context,
                  animationType: _animationType,
                  builder: (context) {
                    return Dialog(
                      insetPadding: const EdgeInsets.only(
                        bottom: 46,
                      ),
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: 380,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'title',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Lorem sit culpa veniam dolor eu eu reprehenderit minim aliquip. Dolor ipsum elit incididunt commodo laborum elit Lorem sit. Laboris anim eu ex dolore et. Exercitation ullamco in cupidatat est dolor deserunt exercitation tempor reprehenderit.',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Text('show dialog'),
            ),
          ],
        ),
      ),
    );
  }
}
