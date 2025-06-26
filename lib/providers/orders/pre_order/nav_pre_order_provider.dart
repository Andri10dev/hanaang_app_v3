import 'package:flutter_riverpod/flutter_riverpod.dart';

final navPreOrderProvider = StateNotifierProvider<NaviController, int>((ref) {
  return NaviController();
});

class NaviController extends StateNotifier<int> {
  NaviController() : super(0);

  void setIndex(int index) async {
    state = index;
  }
}

final statusPoProvider = StateProvider<String>((ref) => 'semua');
