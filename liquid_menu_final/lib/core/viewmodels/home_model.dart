import 'package:flutter/cupertino.dart';

class HomeModel extends ChangeNotifier {
  double _openValue = 0.0;
  get openValue => _openValue;
  set openValue(value) {
    _openValue = value;
    notifyListeners();
  }

  bool _isOpening = false;
  get isOpening => _isOpening;
  set isOpening(value) {
    _isOpening = value;
    notifyListeners();
  }

  void openLiquidMenu(AnimationController controller) {
    print('Menu is opening..');
    isOpening = !isOpening;
    if (isOpening) {
      openValue = 75.0;
      controller.forward();
    } else {
      openValue = 0.0;
      controller.reset();
    }
    notifyListeners();
  }
}
