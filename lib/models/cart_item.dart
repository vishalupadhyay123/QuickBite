import 'restaurant.dart';

class CartItem {
  final MenuItem item;
  final Restaurant restaurant;
  int quantity;
  final List<AddOn> selectedAddOns;
  final String? variant;

  CartItem({
    required this.item,
    required this.restaurant,
    this.quantity = 1,
    this.selectedAddOns = const [],
    this.variant,
  });

  double get addOnsTotal =>
      selectedAddOns.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);

  double get unitPrice => item.price + addOnsTotal;

  double get totalPrice => unitPrice * quantity;
}
