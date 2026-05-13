import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import 'restaurant_detail_screen.dart';

// Home screen — matches Figma home frame with greeting, search,
// category chips, recommended carousel, and nearby restaurant list.
class HomeScreen extends StatefulWidget {
  /// Called when the user taps the search bar — switches to the Search tab.
  final VoidCallback? onSearchTap;
  const HomeScreen({super.key, this.onSearchTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List<Map<String, dynamic>> _categories = [
    {'label': 'Pizza',   'icon': Icons.local_pizza_outlined},
    {'label': 'Burgers', 'icon': Icons.lunch_dining_outlined},
    {'label': 'Sushi',   'icon': Icons.set_meal_outlined},
    {'label': 'Healthy', 'icon': Icons.eco_outlined},
    {'label': 'Drinks',  'icon': Icons.local_drink_outlined},
  ];

  void _openRestaurant(Restaurant r) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => RestaurantDetailScreen(restaurant: r)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final restaurants = SampleData.restaurants;
    final recommended = SampleData.recommendedItems;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // ── Top row ────────────────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Hi User, what would\nyou like to eat today?',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.dark,
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppTheme.lightGray,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    size: 20,
                                    color: AppTheme.dark,
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppTheme.lightGray,
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=80&h=80&fit=crop&q=80',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // ── Delivery location ──────────────────────
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined,
                            size: 16, color: AppTheme.primary),
                        SizedBox(width: 4),
                        Text(
                          'Deliver to: ',
                          style: TextStyle(fontSize: 13, color: AppTheme.gray),
                        ),
                        Text(
                          'Melbourne CBD',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primary,
                          ),
                        ),
                        SizedBox(width: 2),
                        Icon(Icons.keyboard_arrow_down,
                            size: 16, color: AppTheme.primary),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // ── Search bar ─────────────────────────────
                    // Tapping navigates to the Search tab (via onSearchTap).
                    // AbsorbPointer prevents the keyboard from opening here.
                    GestureDetector(
                      onTap: widget.onSearchTap,
                      child: AbsorbPointer(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppTheme.lightGray,
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 16),
                              const Icon(Icons.search,
                                  color: AppTheme.gray, size: 20),
                              const SizedBox(width: 10),
                              const Expanded(
                                child: Text(
                                  'Search food, restaurants, or cuisines',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFFBDBDBD),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(6),
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppTheme.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.tune,
                                  size: 18,
                                  color: AppTheme.dark,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ── Category chips ─────────────────────────
                    SizedBox(
                      height: 80,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (_, i) {
                          final cat = _categories[i];
                          return Column(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: AppTheme.lightGray,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  cat['icon'] as IconData,
                                  color: AppTheme.dark,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                cat['label'] as String,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.dark,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ── Recommended section header ─────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recommended for You',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: AppTheme.primary,
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // ── Recommended horizontal scroll ──────────
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: recommended.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 14),
                        itemBuilder: (_, i) {
                          final item = recommended[i];
                          final restaurant = SampleData.restaurants
                              .firstWhere((r) => r.id == item['restaurantId']);
                          return GestureDetector(
                            onTap: () => _openRestaurant(restaurant),
                            child: _RecommendedCard(item: item),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    // ── Nearby restaurants header ──────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nearby Restaurants',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: AppTheme.primary,
                          ),
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            // ── Nearby restaurant list ─────────────────────────
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  final r = restaurants[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 6,
                    ),
                    child: GestureDetector(
                      onTap: () => _openRestaurant(r),
                      child: _NearbyCard(restaurant: r),
                    ),
                  );
                },
                childCount: restaurants.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}

// ── Recommended card (horizontal scroll) ─────────────────────────
class _RecommendedCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const _RecommendedCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFF0F0F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(14)),
                child: Image.network(
                  item['imageUrl'] as String,
                  width: 160,
                  height: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 160,
                    height: 110,
                    color: AppTheme.primaryLight,
                    child: const Icon(
                      Icons.fastfood,
                      color: AppTheme.primary,
                      size: 36,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6, vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          size: 11, color: Color(0xFFFFC107)),
                      const SizedBox(width: 2),
                      Text(
                        '${item['rating']}',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'] as String,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.dark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['restaurant'] as String,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.gray,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['price'] as String,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primary,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined,
                            size: 11, color: AppTheme.gray),
                        const SizedBox(width: 2),
                        Text(
                          item['time'] as String,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.gray,
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

// ── Nearby restaurant list card ───────────────────────────────────
class _NearbyCard extends StatelessWidget {
  final Restaurant restaurant;
  const _NearbyCard({required this.restaurant});

  @override
  Widget build(BuildContext context) {
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
              restaurant.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 64,
                height: 64,
                color: AppTheme.primaryLight,
                child: const Icon(
                  Icons.restaurant,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.dark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  restaurant.cuisine,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.gray,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Color(0xFFFFC107)),
                    const SizedBox(width: 3),
                    Text(
                      '${restaurant.rating}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.dark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.location_on_outlined,
                        size: 12, color: AppTheme.gray),
                    const SizedBox(width: 2),
                    Text(
                      restaurant.distance,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.gray,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        restaurant.deliveryFee,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: restaurant.deliveryFee.contains('Free')
                              ? AppTheme.green
                              : AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
