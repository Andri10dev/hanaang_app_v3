import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hanaang_app/providers/auths/local_storage_provider.dart';
import 'package:hanaang_app/providers/general/banner_provider.dart';
import 'package:hanaang_app/providers/orders/open_po_provider.dart';
import 'package:hanaang_app/providers/orders/order_provider.dart';
import 'package:hanaang_app/providers/orders/pre_order/pre_order_provider.dart';
import 'package:hanaang_app/providers/orders/retur_order_provider.dart';

final dataRefreshProvider =
    StateNotifierProvider<DataRefreshNotifier, bool>((ref) {
  return DataRefreshNotifier(ref);
});

class DataRefreshNotifier extends StateNotifier<bool> {
  final Ref _ref;

  DataRefreshNotifier(this._ref) : super(false);

  Future<void> refreshAllData() async {
    state = true;

    try {
      // Refresh semua provider data
      _ref.invalidate(getBanner);
      _ref.invalidate(getOpenPreOrderProvider);
      _ref.invalidate(getOrderProvider);
      _ref.invalidate(getPreOrderProvider);
      _ref.invalidate(getReturOrderProvider);
      _ref.invalidate(getUserRoleProvider);
      _ref.invalidate(getUniqueIdProvider);
      _ref.invalidate(getEmailProvider);
      _ref.invalidate(getNameProvider);
      _ref.invalidate(getPhoneNumberProvider);
      _ref.invalidate(getTokenProvider);

      // Tunggu sebentar untuk memastikan data ter-refresh
      await Future.delayed(const Duration(milliseconds: 500));
    } finally {
      state = false;
    }
  }
}
