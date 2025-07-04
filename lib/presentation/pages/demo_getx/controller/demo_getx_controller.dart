import 'dart:async';

import 'package:get/get.dart';
import 'package:training_softdreams/configs/enums.dart';

class DemoGetXController extends GetxController {
  var status = LoadingStatus.initial.obs;
  RxInt count = 0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    onFetchData();
  }

  Future<void> onFetchData() async {
    status.value = LoadingStatus.loading;
    await Future.delayed(Duration(seconds: 2));
    status.value = LoadingStatus.success;
  }

  void onStartTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      count.value++;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
