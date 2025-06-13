// provider/order_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderCountProvider = StateProvider<int>((ref) => 100);

const int unitPrice = 5000;

int getBonus(int count) => (count ~/ 500); // 2 cup per 1000
int getCashback(int count) => (count ~/ 1000) * 2000;
int getTotalPrice(int count) => count * unitPrice;
