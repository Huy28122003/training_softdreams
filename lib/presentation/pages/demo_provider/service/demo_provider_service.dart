import 'package:flutter/foundation.dart';

import '../../../../configs/enums.dart';

class DemoProviderService extends ChangeNotifier {
  LoadingStatus status = LoadingStatus.initial;
  int volume = 5;

  void increase() {
    if (volume < 10) volume++;
    notifyListeners();
  }

  void decrease() {
    if (volume > 0) volume--;
    notifyListeners();
  }
}
