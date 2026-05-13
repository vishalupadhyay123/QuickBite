import 'package:flutter/foundation.dart';
import '../models/restaurant.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  bool _promoApplied = false;
  String _deliveryOption = 'Standard'; // 'Standard' or 'Express'

  // ── Getters ──────────────────────────────────────────────────────
  List<CartItem> get items => _items;
  bool get isEmpty => _items.isEmpty;
  bool get promoApplied => _promoApplied;
  String get deliveryOption => _deliveryOption;

  int get itemCount => _items.fold(0, (sum, i) => sum + i.quantity);

  double get subtotal => _items.fold(0.0, (sum, i) => sum + i.totalPrice);
  double get deliveryFee => _deliveryOption == 'Express' ? 5.99 : 2.99;
  double get serviceFee => 1.50;
  double get discount => _promoApplied ? 2.00 : 0.0;
  double get total => subtotal + deliveryFee + serviceFee - discount;

  Restaurant? get restaurant =>
      _items.isNotEmpty ? _items.first.restaurant : null;

  // ── Actions ──────────────────────────────────────────────────────
  void addItem(
    MenuItem menuItem,
    Restaurant restaurant,
    int qty,
    List<AddOn> addOns, [
    String? variant,
  ]) {
    _items.add(CartItem(
      item: menuItem,
      restaurant: restaurant,
      quantity: qty,
      selectedAddOns: addOns,
      variant: variant,
    ));
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void applyPromo(String code) {
    if (code.trim().isNotEmpty) {
      _promoApplied = true;
      notifyListeners();
    }
  }

  void setDeliveryOption(String option) {
    _deliveryOption = option;
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _promoApplied = false;
    _deliveryOption = 'Standard';
    notifyListeners();
  }
}
