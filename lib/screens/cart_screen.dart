import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import 'checkout_screen.dart';

// Cart screen — "My Cart" — matches Figma cart frame
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _promoCtrl = TextEditingController();

  @override
  void dispose() {
    _promoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Cart'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(18),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Review your order before checkout',
              style: const TextStyle(fontSize: 13, color: AppTheme.gray),
            ),
          ),
        ),
      ),
      body: cart.isEmpty
          ? _EmptyCart()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        // ── Restaurant name ─────────────────────
                        if (cart.restaurant != null)
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryLight,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.storefront_outlined,
                                  size: 16,
                                  color: AppTheme.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                cart.restaurant!.name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.dark,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 16),
                        // ── Cart items ──────────────────────────
                        ...List.generate(cart.items.length, (i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: _CartItemRow(
                              index: i,
                              cart: cart,
                            ),
                          );
                        }),
                        const Divider(height: 24),
                        // ── Promo code ──────────────────────────
                        const Text(
                          'Promo Code',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _promoCtrl,
                                decoration: InputDecoration(
                                  hintText: 'Enter promo code',
                                  prefixIcon: const Icon(
                                    Icons.local_offer_outlined,
                                    size: 18,
                                    color: AppTheme.gray,
                                  ),
                                  filled: true,
                                  fillColor: AppTheme.lightGray,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                cart.applyPromo(_promoCtrl.text);
                                if (_promoCtrl.text.isNotEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Promo code applied! -\$2.00'),
                                      backgroundColor: AppTheme.green,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(80, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                              ),
                              child: const Text('Apply'),
                            ),
                          ],
                        ),
                        const Divider(height: 28),
                        // ── Price breakdown ─────────────────────
                        _PriceRow(label: 'Subtotal',
                            value: '\$${cart.subtotal.toStringAsFixed(2)}'),
                        const SizedBox(height: 10),
                        _PriceRow(label: 'Delivery Fee',
                            value: '\$${cart.deliveryFee.toStringAsFixed(2)}'),
                        const SizedBox(height: 10),
                        _PriceRow(label: 'Service Fee',
                            value: '\$${cart.serviceFee.toStringAsFixed(2)}'),
                        if (cart.promoApplied) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Discount',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '-\$2.00',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.dark,
                              ),
                            ),
                            Text(
                              '\$${cart.total.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.dark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // ── Estimated delivery ──────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.access_time_outlined,
                              size: 14,
                              color: AppTheme.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Estimated delivery: ${cart.restaurant?.time ?? '20-25 min'}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppTheme.gray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                // ── Proceed to Checkout button ──────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    20, 8, 20, 16 + MediaQuery.of(context).padding.bottom,
                  ),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CheckoutScreen(),
                      ),
                    ),
                    child: const Text('Proceed to Checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}

// ── Cart item row ─────────────────────────────────────────────────
class _CartItemRow extends StatelessWidget {
  final int index;
  final CartProvider cart;
  const _CartItemRow({required this.index, required this.cart});

  @override
  Widget build(BuildContext context) {
    final ci = cart.items[index];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              ci.item.imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 72,
                height: 72,
                color: AppTheme.lightGray,
                child: const Icon(Icons.fastfood,
                    color: AppTheme.gray, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        ci.item.name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.dark,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => cart.removeItem(index),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppTheme.gray,
                      ),
                    ),
                  ],
                ),
                if (ci.selectedAddOns.isNotEmpty)
                  Text(
                    ci.selectedAddOns.map((a) => a.name).join(', '),
                    style: const TextStyle(
                      fontSize: 12, color: AppTheme.gray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${ci.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dark,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => cart.decrementQuantity(index),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppTheme.lightGray,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.remove,
                                size: 16, color: AppTheme.dark),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${ci.quantity}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => cart.incrementQuantity(index),
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.add,
                                size: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Price row helper ──────────────────────────────────────────────
class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  const _PriceRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 14, color: AppTheme.gray)),
        Text(value,
            style: const TextStyle(
                fontSize: 14, color: AppTheme.dark)),
      ],
    );
  }
}

// ── Empty cart placeholder ────────────────────────────────────────
class _EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: AppTheme.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shopping_cart_outlined,
              color: AppTheme.primary,
              size: 48,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.dark,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Add items from a restaurant to get started',
            style: TextStyle(fontSize: 13, color: AppTheme.gray),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
