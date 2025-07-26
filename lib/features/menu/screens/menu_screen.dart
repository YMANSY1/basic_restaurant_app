import 'package:basic_restaurant_app/features/menu/controllers/cart_controller.dart';
import 'package:basic_restaurant_app/features/menu/models/food_item.dart';
import 'package:basic_restaurant_app/features/menu/screens/cart_screen.dart';
import 'package:basic_restaurant_app/features/menu/services/menu_service.dart';
import 'package:basic_restaurant_app/features/menu/widgets/expandable_cart_fab.dart';
import 'package:basic_restaurant_app/features/menu/widgets/food_category_button.dart';
import 'package:basic_restaurant_app/features/menu/widgets/menu_banner.dart';
import 'package:basic_restaurant_app/features/menu/widgets/menu_sliver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/menu_controller.dart' as menu_controller;
import '../models/food_category.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(menu_controller.MenuController());
    final cartController = Get.put(CartController());
    final menuService = MenuService(FirebaseFirestore.instance);
    List<FoodCategory> allCategories = FoodCategory.values;

    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<FoodItem>>(
          future: menuService.getMenu(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading menu'),
              );
            }

            final menuItems = snapshot.data ?? [];

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: MenuBanner(),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: allCategories.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final category = allCategories[index];
                        return Obx(() {
                          final bool isSelected =
                              menuController.selectedIndex == index;
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FoodCategoryButton(
                              categoryName: category.name,
                              icon: category.icon,
                              isSelected: isSelected,
                              onTap: () {
                                menuController.selectCategory(index);
                              },
                            ),
                          );
                        });
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(width: 10),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 24),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  sliver: Obx(() {
                    final selectedCategory =
                        allCategories[menuController.selectedIndex];

                    final filteredItems = menuItems
                        .where((item) => item.category == selectedCategory)
                        .toList();

                    if (filteredItems.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text('No items available in this category'),
                        ),
                      );
                    }

                    return MenuSliver(filteredItems: filteredItems);
                  }),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Obx(() {
          return ExpandableCartFAB(
            cartItemCount: cartController.totalItems,
            onCartTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => CartScreen())),
          );
        }),
      ),
    );
  }
}
