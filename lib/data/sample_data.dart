import '../models/restaurant.dart';

// All restaurant and menu data matching the Figma screens.
class SampleData {
  static final List<Restaurant> restaurants = [
    // ── Urban Bites ──────────────────────────────────────────────
    Restaurant(
      id: 'urban-bites',
      name: 'Urban Bites',
      cuisine: 'Burgers & Wraps',
      rating: 4.7,
      time: '20-25 min',
      distance: '1.2 km',
      deliveryFee: '\$2.99 delivery',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&h=300&fit=crop&q=80',
      description:
          'Fresh burgers, wraps, fries, and quick bites made for busy days',
      categories: ['Popular', 'Burgers', 'Wraps', 'Sides', 'Drinks'],
      isRecommended: true,
      menu: [
        MenuItem(
          id: 'chicken-burger',
          name: 'Chicken Burger',
          description: 'Crispy chicken, lettuce, cheese, and spicy mayo',
          price: 12.90,
          imageUrl:
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=300&fit=crop&q=80',
          category: 'Popular',
          isPopular: true,
          addOns: [
            AddOn(id: 'cheese', name: 'Extra Cheese', price: 1.50),
            AddOn(id: 'fries', name: 'Fries Combo', price: 3.00),
            AddOn(id: 'drink', name: 'Soft Drink', price: 2.50),
            AddOn(id: 'onions', name: 'No Onions', price: 0),
          ],
        ),
        MenuItem(
          id: 'beef-burger',
          name: 'Classic Beef Burger',
          description: 'Beef patty, tomato, lettuce, cheese',
          price: 13.50,
          imageUrl:
              'https://images.unsplash.com/photo-1553979459-d2229ba7433b?w=300&h=300&fit=crop&q=80',
          category: 'Burgers',
        ),
        MenuItem(
          id: 'grilled-wrap',
          name: 'Grilled Chicken Wrap',
          description: 'Grilled chicken, fresh salad, garlic sauce',
          price: 11.90,
          imageUrl:
              'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=300&h=300&fit=crop&q=80',
          category: 'Wraps',
        ),
        MenuItem(
          id: 'loaded-fries',
          name: 'Loaded Fries',
          description: 'Fries with cheese sauce and herbs',
          price: 7.50,
          imageUrl:
              'https://images.unsplash.com/photo-1576107232684-1279f8ba9a4b?w=300&h=300&fit=crop&q=80',
          category: 'Sides',
        ),
        MenuItem(
          id: 'soft-drink',
          name: 'Soft Drink',
          description: 'Cola, Lemonade, or Orange juice',
          price: 2.50,
          imageUrl:
              'https://images.unsplash.com/photo-1561758033-d89a9ad46330?w=300&h=300&fit=crop&q=80',
          category: 'Drinks',
        ),
      ],
    ),

    // ── Green Spoon ───────────────────────────────────────────────
    Restaurant(
      id: 'green-spoon',
      name: 'Green Spoon',
      cuisine: 'Healthy Salads & Bowls',
      rating: 4.8,
      time: '25-30 min',
      distance: '1.8 km',
      deliveryFee: 'Free delivery',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&h=300&fit=crop&q=80',
      description:
          'Fresh, nourishing bowls and salads crafted for the health-conscious',
      categories: ['Popular', 'Bowls', 'Salads', 'Juices', 'Snacks'],
      menu: [
        MenuItem(
          id: 'vegan-bowl',
          name: 'Vegan Bowl',
          description: 'Quinoa, roasted veggies, tahini dressing',
          price: 14.90,
          imageUrl:
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300&h=300&fit=crop&q=80',
          category: 'Bowls',
          isPopular: true,
          addOns: [
            AddOn(id: 'avocado', name: 'Extra Avocado', price: 2.00),
            AddOn(id: 'protein', name: 'Add Tofu', price: 3.00),
          ],
        ),
        MenuItem(
          id: 'green-juice',
          name: 'Green Juice',
          description: 'Spinach, cucumber, apple, ginger',
          price: 7.50,
          imageUrl:
              'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=300&h=300&fit=crop&q=80',
          category: 'Juices',
        ),
        MenuItem(
          id: 'caesar-salad',
          name: 'Caesar Salad',
          description: 'Cos lettuce, croutons, parmesan, caesar dressing',
          price: 12.50,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300&h=300&fit=crop&q=80',
          category: 'Salads',
        ),
      ],
    ),

    // ── Pizza House ───────────────────────────────────────────────
    Restaurant(
      id: 'pizza-house',
      name: 'Pizza House',
      cuisine: 'Italian / Pizza',
      rating: 4.6,
      time: '30-35 min',
      distance: '2.1 km',
      deliveryFee: '\$3.50 delivery',
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&h=300&fit=crop&q=80',
      description: 'Authentic Italian pizzas baked in a wood-fired oven',
      categories: ['Popular', 'Pizzas', 'Pasta', 'Sides', 'Drinks'],
      menu: [
        MenuItem(
          id: 'margherita',
          name: 'Margherita Pizza',
          description: 'Tomato sauce, mozzarella, fresh basil',
          price: 16.90,
          imageUrl:
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&h=300&fit=crop&q=80',
          category: 'Pizzas',
          isPopular: true,
          addOns: [
            AddOn(id: 'extra-cheese', name: 'Extra Cheese', price: 2.00),
            AddOn(id: 'olives', name: 'Add Olives', price: 1.50),
          ],
        ),
        MenuItem(
          id: 'garlic-bread',
          name: 'Garlic Bread',
          description: 'Toasted bread with garlic butter and herbs',
          price: 5.90,
          imageUrl:
              'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=300&h=300&fit=crop&q=80',
          category: 'Sides',
        ),
        MenuItem(
          id: 'pasta-arabiata',
          name: 'Pasta Arabiata',
          description: 'Penne pasta, spicy tomato sauce, garlic',
          price: 14.50,
          imageUrl:
              'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=300&h=300&fit=crop&q=80',
          category: 'Pasta',
        ),
      ],
    ),

    // ── Sushi Go ──────────────────────────────────────────────────
    Restaurant(
      id: 'sushi-go',
      name: 'Sushi Go',
      cuisine: 'Japanese / Sushi',
      rating: 4.9,
      time: '20-30 min',
      distance: '2.5 km',
      deliveryFee: '\$2.50 delivery',
      imageUrl:
          'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=600&h=300&fit=crop&q=80',
      description: 'Premium sushi and Japanese favourites delivered fresh',
      categories: ['Popular', 'Rolls', 'Nigiri', 'Sides', 'Drinks'],
      menu: [
        MenuItem(
          id: 'salmon-roll',
          name: 'Salmon Roll (8 pcs)',
          description: 'Fresh salmon, avocado, cucumber in sushi rice',
          price: 15.90,
          imageUrl:
              'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=300&h=300&fit=crop&q=80',
          category: 'Rolls',
          isPopular: true,
          addOns: [
            AddOn(id: 'wasabi', name: 'Extra Wasabi', price: 0),
            AddOn(id: 'ginger', name: 'Extra Ginger', price: 0),
          ],
        ),
        MenuItem(
          id: 'edamame',
          name: 'Edamame',
          description: 'Steamed salted edamame beans',
          price: 6.50,
          imageUrl:
              'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=300&h=300&fit=crop&q=80',
          category: 'Sides',
        ),
        MenuItem(
          id: 'miso-soup',
          name: 'Miso Soup',
          description: 'Traditional Japanese miso broth with tofu',
          price: 4.50,
          imageUrl:
              'https://images.unsplash.com/photo-1547592180-85f173990554?w=300&h=300&fit=crop&q=80',
          category: 'Sides',
        ),
      ],
    ),
  ];

  // Recommended food items for home screen carousel
  static List<Map<String, dynamic>> get recommendedItems => [
        {
          'name': 'Chicken Burger',
          'restaurant': 'Urban Bites',
          'price': '\$12.90',
          'time': '20 min',
          'rating': 4.7,
          'imageUrl':
              'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop&q=80',
          'restaurantId': 'urban-bites',
          'itemId': 'chicken-burger',
        },
        {
          'name': 'Vegan Bowl',
          'restaurant': 'Green Spoon',
          'price': '\$14.50',
          'time': '25 min',
          'rating': 4.8,
          'imageUrl':
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300&h=200&fit=crop&q=80',
          'restaurantId': 'green-spoon',
          'itemId': 'vegan-bowl',
        },
        {
          'name': 'Margherita Pizza',
          'restaurant': 'Pizza House',
          'price': '\$16.90',
          'time': '30 min',
          'rating': 4.6,
          'imageUrl':
              'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&h=200&fit=crop&q=80',
          'restaurantId': 'pizza-house',
          'itemId': 'margherita',
        },
        {
          'name': 'Salmon Roll',
          'restaurant': 'Sushi Go',
          'price': '\$15.90',
          'time': '25 min',
          'rating': 4.9,
          'imageUrl':
              'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=300&h=200&fit=crop&q=80',
          'restaurantId': 'sushi-go',
          'itemId': 'salmon-roll',
        },
      ];

  // Past orders for profile + orders screen
  static final List<Map<String, dynamic>> pastOrders = [
    {
      'id': '#QB10248',
      'restaurant': 'Urban Bites',
      'date': '2 Apr 2026',
      'items': 'Chicken Burger, Loaded Fries, Soft Drink',
      'total': '\$26.89',
      'status': 'Delivered',
    },
    {
      'id': '#QB10231',
      'restaurant': 'Green Spoon',
      'date': '30 Mar 2026',
      'items': 'Vegan Bowl, Green Juice',
      'total': '\$18.50',
      'status': 'Delivered',
    },
    {
      'id': '#QB10215',
      'restaurant': 'Pizza House',
      'date': '28 Mar 2026',
      'items': 'Margherita Pizza, Garlic Bread',
      'total': '\$22.00',
      'status': 'Delivered',
    },
  ];
}
