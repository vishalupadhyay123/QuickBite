import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

// Item detail screen — matches Figma "Chicken Burger" detail frame
class ItemDetailScreen extends StatefulWidget {
  final MenuItem item;
  final Restaurant restaurant;
  const ItemDetailScreen({
    super.key,
    required this.item,
    required this.restaurant,
  });

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  int _quantity = 1;
  bool _isFav = false;
  late List<AddOn> _addOns;
  final _specialCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Deep copy add-ons so selection state is local to this screen
    _addOns = widget.item.addOns.map((a) => a.copy()).toList();
  }

  @override
  void dispose() {
    _specialCtrl.dispose();
    super.dispose();
  }

  double get _addOnsTotal =>
      _addOns.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);

  double get _total => (widget.item.price + _addOnsTotal) * _quantity;

  void _addToCart() {
    context.read<CartProvider>().addItem(
          widget.item,
          widget.restaurant,
          _quantity,
          _addOns.where((a) => a.isSelected).toList(),
        );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.item.name} added to cart!'),
        backgroundColor: AppTheme.primary,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        children: [
          // ── Hero image with overlay buttons ────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Image.network(
                        item.imageUrl,
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: double.infinity,
                          height: 280,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppTheme.primary.withValues(alpha: 0.7),
                                AppTheme.primaryDark,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: const Icon(
                            Icons.fastfood,
                            color: Colors.white,
                            size: 72,
                          ),
                        ),
                      ),
                      // Back button overlay
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        left: 16,
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                      ),
                      // Favourite button overlay
                      Positioned(
                        top: MediaQuery.of(context).padding.top + 8,
                        right: 16,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _isFav = !_isFav),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isFav
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 20,
                              color: _isFav ? Colors.red : AppTheme.dark,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // ── Item info ─────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.dark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.dark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                size: 14, color: Color(0xFFFFC107)),
                            const SizedBox(width: 4),
                            const Text(
                              '4.7',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(Icons.access_time_outlined,
                                size: 13, color: AppTheme.gray),
                            const SizedBox(width: 4),
                            Text(
                              'Ready in ${widget.restaurant.time}',
                              style: const TextStyle(
                                fontSize: 13, color: AppTheme.gray,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppTheme.gray,
                            height: 1.5,
                          ),
                        ),
                        const Divider(height: 28),
                        // ── Quantity ─────────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.dark,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_quantity > 1) {
                                      setState(() => _quantity--);
                                    }
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppTheme.lightGray,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      size: 18,
                                      color: AppTheme.dark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  '$_quantity',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _quantity++),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(height: 28),
                        // ── Add-ons ───────────────────────────────
                        if (_addOns.isNotEmpty) ...[
                          const Text(
                            'Add-ons',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.dark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              color: AppTheme.lightGray,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              children: List.generate(_addOns.length, (i) {
                                final a = _addOns[i];
                                return _AddOnRow(
                                  addOn: a,
                                  isLast: i == _addOns.length - 1,
                                  onChanged: (v) =>
                                      setState(() => a.isSelected = v),
                                );
                              }),
                            ),
                          ),
                          const Divider(height: 28),
                        ],
                        // ── Special instructions ──────────────────
                        const Text(
                          'Special Instructions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _specialCtrl,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Add cooking or delivery notes...',
                            filled: true,
                            fillColor: AppTheme.lightGray,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // ── Bottom total + add to cart ──────────────────────
          Container(
            padding: EdgeInsets.fromLTRB(
              20, 12, 20, 12 + MediaQuery.of(context).padding.bottom,
            ),
            decoration: const BoxDecoration(
              color: AppTheme.white,
              border: Border(top: BorderSide(color: Color(0xFFF0F0F0))),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Total (inc. add-ons)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.gray,
                      ),
                    ),
                    Text(
                      '\$${_total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.dark,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addToCart,
                    icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                    label: const Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Add-on checkbox row ───────────────────────────────────────────
class _AddOnRow extends StatelessWidget {
  final AddOn addOn;
  final bool isLast;
  final ValueChanged<bool> onChanged;
  const _AddOnRow({
    required this.addOn,
    required this.isLast,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: addOn.isSelected,
                  onChanged: (v) => onChanged(v ?? false),
                  activeColor: AppTheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  addOn.name,
                  style: const TextStyle(
                    fontSize: 14, color: AppTheme.dark,
                  ),
                ),
              ),
              Text(
                addOn.price == 0
                    ? 'Free'
                    : '+\$${addOn.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.dark,
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          const Divider(height: 1, indent: 14, endIndent: 14),
      ],
    );
  }
}
