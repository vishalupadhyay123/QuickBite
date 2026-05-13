import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import 'track_order_screen.dart';

// Checkout screen — matches Figma checkout frame
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _deliveryOption = 'Standard';
  bool _placing = false;
  final _instructionsCtrl = TextEditingController();

  @override
  void dispose() {
    _instructionsCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder(CartProvider cart) async {
    setState(() => _placing = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    cart.clearCart();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const TrackOrderScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final deliveryFee =
        _deliveryOption == 'Express' ? 5.99 : 2.99;
    final total = cart.subtotal + deliveryFee + cart.serviceFee - cart.discount;

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        title: const Text('Checkout'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(18),
          child: const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              'Confirm your order details',
              style: TextStyle(fontSize: 13, color: AppTheme.gray),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // ── Delivery Address ──────────────────────────
                  _SectionTitle('Delivery Address'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGray,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppTheme.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            size: 18,
                            color: AppTheme.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '221B Swanston Street,\nMelbourne CBD',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.dark,
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '+61 4XX XXX XXX',
                                style: TextStyle(
                                  fontSize: 12, color: AppTheme.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.primary,
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                          ),
                          child: const Text(
                            'Change',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ── Delivery Option ───────────────────────────
                  _SectionTitle('Delivery Option'),
                  const SizedBox(height: 10),
                  _DeliveryOptionTile(
                    label: 'Standard Delivery',
                    subtitle: '20-25 min',
                    price: 'Free',
                    selected: _deliveryOption == 'Standard',
                    onTap: () {
                      setState(() => _deliveryOption = 'Standard');
                      cart.setDeliveryOption('Standard');
                    },
                  ),
                  const SizedBox(height: 10),
                  _DeliveryOptionTile(
                    label: 'Express Delivery',
                    subtitle: '10-15 min',
                    price: '+\$3.00',
                    selected: _deliveryOption == 'Express',
                    onTap: () {
                      setState(() => _deliveryOption = 'Express');
                      cart.setDeliveryOption('Express');
                    },
                  ),
                  const SizedBox(height: 24),
                  // ── Payment Method ────────────────────────────
                  _SectionTitle('Payment Method'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGray,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.credit_card_outlined,
                            size: 18,
                            color: AppTheme.dark,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Credit / Debit Card',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.dark,
                                ),
                              ),
                              Text(
                                'Card ending in 1234',
                                style: TextStyle(
                                  fontSize: 12, color: AppTheme.gray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.edit_outlined,
                          size: 18,
                          color: AppTheme.gray,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // ── Delivery instructions ─────────────────────
                  TextField(
                    controller: _instructionsCtrl,
                    decoration: InputDecoration(
                      hintText: 'Add delivery instructions',
                      helperText: 'e.g. Leave at reception / Call on arrival',
                      helperStyle: const TextStyle(
                        fontSize: 11, color: AppTheme.gray,
                      ),
                      prefixIcon: const Icon(
                        Icons.assignment_outlined,
                        size: 18,
                        color: AppTheme.gray,
                      ),
                      filled: true,
                      fillColor: AppTheme.lightGray,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // ── Order Summary ─────────────────────────────
                  _SectionTitle('Order Summary'),
                  const SizedBox(height: 12),
                  ...cart.items.map((ci) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${ci.quantity}x  ${ci.item.name}',
                              style: const TextStyle(
                                fontSize: 13, color: AppTheme.dark,
                              ),
                            ),
                            Text(
                              '\$${ci.totalPrice.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 13, color: AppTheme.dark,
                              ),
                            ),
                          ],
                        ),
                      )),
                  const Divider(height: 20),
                  _SummaryRow('Subtotal',
                      '\$${cart.subtotal.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _SummaryRow('Delivery Fee',
                      '\$${deliveryFee.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _SummaryRow('Service Fee',
                      '\$${cart.serviceFee.toStringAsFixed(2)}'),
                  if (cart.promoApplied) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Discount',
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.green)),
                        Text('-\$2.00',
                            style: TextStyle(
                                fontSize: 13, color: AppTheme.green,
                                fontWeight: FontWeight.w600)),
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
                        '\$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // ── Place Order button ──────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              20, 8, 20, 16 + MediaQuery.of(context).padding.bottom,
            ),
            child: ElevatedButton(
              onPressed: _placing ? null : () => _placeOrder(cart),
              child: _placing
                  ? const SizedBox(
                      height: 22,
                      width: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Place Order'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppTheme.dark,
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: AppTheme.gray)),
        Text(value,
            style: const TextStyle(fontSize: 13, color: AppTheme.dark)),
      ],
    );
  }
}

class _DeliveryOptionTile extends StatelessWidget {
  final String label;
  final String subtitle;
  final String price;
  final bool selected;
  final VoidCallback onTap;
  const _DeliveryOptionTile({
    required this.label,
    required this.subtitle,
    required this.price,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppTheme.primaryLight : AppTheme.lightGray,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppTheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppTheme.primary : AppTheme.gray,
                  width: 2,
                ),
                color: selected ? AppTheme.primary : Colors.transparent,
              ),
              child: selected
                  ? const Icon(Icons.circle,
                      size: 10, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.dark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12, color: AppTheme.gray,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.dark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
