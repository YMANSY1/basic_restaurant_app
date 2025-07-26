import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../models/cart_item.dart';
import '../models/food_item.dart';
import 'food_item_card.dart';

class MenuSliver extends StatelessWidget {
  const MenuSliver({
    super.key,
    required this.filteredItems,
  });

  final List<FoodItem> filteredItems;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return FoodItemCard(
          imageUrl: item.imageUrl ?? 'https://via.placeholder.com/300x200',
          foodName: item.name,
          price: item.price,
          onAddToCart: () {
            final cartController = Get.find<CartController>();
            final existingItemIndex = cartController.cartItems.indexWhere(
              (cartItem) => cartItem.item == item,
            );
            if (existingItemIndex != -1) {
              final existingItem = cartController.cartItems[existingItemIndex];
              cartController.incrementQuantity(existingItem);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text(
                        'Increased quantity to ${existingItem.quantity} for ${existingItem.item.name}')));
            } else {
              final cartItem = CartItem(item: item);
              cartController.addToCart(cartItem);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Text('Added ${cartItem.item.name} to cart')));
            }

            print('Added ${item.name} to cart');
          },
        );
      },
    );
  }
}
