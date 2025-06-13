import 'package:flutter_riverpod/flutter_riverpod.dart';

final passwordVisibilityProvider =
    StateNotifierProvider<PasswordVisibilityController, bool>(
  (ref) => PasswordVisibilityController(),
);

class PasswordVisibilityController extends StateNotifier<bool> {
  PasswordVisibilityController() : super(false); // false = sembunyikan password

  void toggle() => state = !state;
}
