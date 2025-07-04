import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:training_softdreams/configs/enums.dart';
import 'package:training_softdreams/presentation/pages/demo_getx/controller/demo_getx_controller.dart';

class DemoGetXView extends GetView<DemoGetXController> {
  const DemoGetXView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo GetX"),
      ),
      body: Obx(
        () {
          if (controller.status.value == LoadingStatus.loading) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (controller.status.value == LoadingStatus.failure) {
            return SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
              ),
              Obx(
                () {
                  return Text(
                    controller.count.value.toString(),
                    style: TextStyle(fontSize: 30),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  controller.onStartTimer();
                },
                child: Text("Start"),
              ),
            ],
          );
        },
      ),
    );
  }
}
