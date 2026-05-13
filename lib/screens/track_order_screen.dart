import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_screen.dart';

// Track Order screen — matches Figma "Order Confirmed" frame
class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _backToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const MainScreen(initialIndex: 0)),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Track Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _backToHome,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // ── Green check animation ─────────────────────────
            ScaleTransition(
              scale: _scale,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.greenLight,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: AppTheme.green,
                  size: 44,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppTheme.dark,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your food is on the way',
              style: TextStyle(fontSize: 14, color: AppTheme.gray),
            ),
            const SizedBox(height: 24),
            // ── Order ID card ─────────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Order ID',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '#QB10248',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.dark,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'Estimated Arrival',
                        style: TextStyle(
                          fontSize: 11,
                          color: AppTheme.gray,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '22 minutes',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ── Progress tracker ──────────────────────────────
            _OrderProgressTracker(currentStep: 2),
            const SizedBox(height: 20),
            // ── Delivery person card ──────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: AppTheme.dark,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bike Delivery',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.star,
                                size: 12, color: Color(0xFFFFC107)),
                            SizedBox(width: 3),
                            Text(
                              '4.9',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppTheme.gray,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      _ActionButton(
                        icon: Icons.chat_bubble_outline,
                        onTap: () {},
                        filled: false,
                      ),
                      const SizedBox(width: 10),
                      _ActionButton(
                        icon: Icons.phone,
                        onTap: () {},
                        filled: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ── Restaurant card ───────────────────────────────
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                              size: 14,
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Urban Bites',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.dark,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '\$26.89',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.dark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.location_on_outlined,
                          size: 13, color: AppTheme.gray),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '221B Swanston Street, Melbourne CBD',
                          style: TextStyle(
                            fontSize: 12, color: AppTheme.gray,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 44),
                      side: const BorderSide(color: AppTheme.midGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Call Restaurant',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppTheme.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // ── View Order Details ────────────────────────────
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: AppTheme.midGray),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'View Order Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.dark,
                ),
              ),
            ),
            const SizedBox(height: 14),
            // ── Back to Home ──────────────────────────────────
            TextButton(
              onPressed: _backToHome,
              child: const Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.dark,
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Progress tracker widget ───────────────────────────────────────
class _OrderProgressTracker extends StatelessWidget {
  final int currentStep; // 0=Confirmed,1=Preparing,2=PickedUp,3=Delivered

  const _OrderProgressTracker({required this.currentStep});

  static const _steps = [
    {'label': 'Confirmed', 'icon': Icons.check},
    {'label': 'Preparing', 'icon': Icons.check},
    {'label': 'Picked Up', 'icon': Icons.directions_bike},
    {'label': 'Delivered', 'icon': Icons.home_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.lightGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            final stepIndex = (i - 1) ~/ 2;
            final done = stepIndex < currentStep;
            return Expanded(
              child: Container(
                height: 3,
                color: done ? AppTheme.green : const Color(0xFFE0E0E0),
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final done = stepIndex < currentStep;
          final active = stepIndex == currentStep;
          final step = _steps[stepIndex];
          return Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: done || active
                      ? AppTheme.green
                      : const Color(0xFFE0E0E0),
                ),
                child: Icon(
                  step['icon'] as IconData,
                  size: 18,
                  color: done || active ? Colors.white : AppTheme.gray,
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: 58,
                child: Text(
                  step['label'] as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: active
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: active ? AppTheme.dark : AppTheme.gray,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Icon action button ────────────────────────────────────────────
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;
  const _ActionButton({
    required this.icon,
    required this.onTap,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: filled ? AppTheme.primary : Colors.white,
          shape: BoxShape.circle,
          border: filled
              ? null
              : Border.all(color: AppTheme.midGray),
        ),
        child: Icon(
          icon,
          size: 18,
          color: filled ? Colors.white : AppTheme.dark,
        ),
      ),
    );
  }
}
