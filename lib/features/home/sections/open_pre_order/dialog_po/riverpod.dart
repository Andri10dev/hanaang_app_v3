// provider/order_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderCountProvider = StateProvider<int>((ref) => 100);

// Provider untuk loading state
final isLoadingProvider = StateProvider<bool>((ref) => false);
