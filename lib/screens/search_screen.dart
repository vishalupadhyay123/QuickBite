import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../models/restaurant.dart';
import '../theme/app_theme.dart';
import 'restaurant_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchCtrl = TextEditingController();
  String _selectedFilter = 'All';
  String _query = '';

  static const List<String> _filters = [
    'All', 'Fast Food', 'Healthy', 'Asian', 'Italian', 'Pizza',
  ];

  List<Restaurant> get _filtered {
    var result = SampleData.restaurants.where((r) {
      if (_query.isNotEmpty) {
        return r.name.toLowerCase().contains(_query.toLowerCase()) ||
            r.cuisine.toLowerCase().contains(_query.toLowerCase());
      }
      return true;
    }).toList();

    if (_selectedFilter != 'All') {
      result = result.where((r) {
        final c = r.cuisine.toLowerCase();
        switch (_selectedFilter) {
          case 'Healthy':   return c.contains('healthy') || c.contains('salad');
          case 'Asian':     return c.contains('japanese') || c.contains('sushi') || c.contains('asian');
          case 'Italian':   return c.contains('italian');
          case 'Pizza':     return c.contains('pizza');
          case 'Fast Food': return c.contains('burger') || c.contains('wrap') || c.contains('fast');
          default:          return true;
        }
      }).toList();
    }
    return result;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filtered;

    return Scaffold(
      backgroundColor: AppTheme.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Restaurants Near You'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFF0F0F0)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Subtitle ──────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            child: Text(
              '${list.length} restaurant${list.length == 1 ? '' : 's'} available',
              style: const TextStyle(fontSize: 13, color: AppTheme.gray),
            ),
          ),
          // ── Search bar ────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.lightGray,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.search, color: AppTheme.gray, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      onChanged: (v) => setState(() => _query = v),
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search restaurants or cuisines',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Color(0xFFBDBDBD),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        filled: false,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
          // ── Filter chips ──────────────────────────────────────
          // Fixed: single-row scroll, no SizedBox height constraint that clips
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: _filters.map((f) {
                  final selected = f == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? AppTheme.dark : AppTheme.lightGray,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Text(
                          f,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: selected
                                ? AppTheme.white
                                : AppTheme.dark,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // ── Restaurant cards ──────────────────────────────────
          Expanded(
            child: list.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.search_off_rounded,
                            color: AppTheme.primary,
                            size: 36,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No restaurants found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.dark,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Try a different search or filter',
                          style: TextStyle(
                            fontSize: 13, color: AppTheme.gray,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    itemCount: list.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (_, i) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              RestaurantDetailScreen(restaurant: list[i]),
                        ),
                      ),
                      child: _RestaurantCard(restaurant: list[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Restaurant card ───────────────────────────────────────────────
class _RestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  const _RestaurantCard({required this.restaurant});

  @override
  State<_RestaurantCard> createState() => _RestaurantCardState();
}

class _RestaurantCardState extends State<_RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    final r = widget.restaurant;
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image ───────────────────────────────────────────
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  r.imageUrl,
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 160,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.primary.withValues(alpha: 0.7),
                          AppTheme.primaryDark,
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
              // Badge
              if (r.isRecommended)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Recommended',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.dark,
                      ),
                    ),
                  ),
                ),
              // Favourite
              Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: () => setState(() => r.isFavorite = !r.isFavorite),
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      r.isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: r.isFavorite ? Colors.red : AppTheme.gray,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ── Info ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + rating on same row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        r.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.dark,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.greenLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star,
                              size: 12, color: AppTheme.green),
                          const SizedBox(width: 3),
                          Text(
                            '${r.rating}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  r.cuisine,
                  style: const TextStyle(fontSize: 13, color: AppTheme.gray),
                ),
                const SizedBox(height: 10),
                // ── Meta row — each item with Flexible to prevent overflow ─
                Row(
                  children: [
                    const Icon(Icons.access_time_outlined,
                        size: 13, color: AppTheme.gray),
                    const SizedBox(width: 4),
                    Text(
                      r.time,
                      style: const TextStyle(
                        fontSize: 12, color: AppTheme.gray,
                      ),
                    ),
                    _dot(),
                    const Icon(Icons.location_on_outlined,
                        size: 13, color: AppTheme.gray),
                    const SizedBox(width: 4),
                    Text(
                      r.distance,
                      style: const TextStyle(
                        fontSize: 12, color: AppTheme.gray,
                      ),
                    ),
                    _dot(),
                    const Icon(Icons.delivery_dining_outlined,
                        size: 13, color: AppTheme.gray),
                    const SizedBox(width: 4),
                    // Flexible prevents delivery fee from overflowing
                    Flexible(
                      child: Text(
                        r.deliveryFee,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: r.deliveryFee.contains('Free')
                              ? AppTheme.green
                              : AppTheme.gray,
                          fontWeight: r.deliveryFee.contains('Free')
                              ? FontWeight.w600
                              : FontWeight.normal,
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

  Widget _dot() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Container(
          width: 3,
          height: 3,
          decoration: const BoxDecoration(
            color: AppTheme.midGray,
            shape: BoxShape.circle,
          ),
        ),
      );
}
