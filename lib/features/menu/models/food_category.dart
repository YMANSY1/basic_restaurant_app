enum FoodCategory {
  breakfast,
  appetizers,
  soups,
  shawerma,
  sandwiches,
  mainDishes,
  vegetarianOptions,
  desserts,
  extras;

  static FoodCategory fromString(String value) {
    switch (value) {
      case 'Breakfast':
        return FoodCategory.breakfast;
      case 'Appetizers':
        return FoodCategory.appetizers;
      case 'Soups':
        return FoodCategory.soups;
      case 'Shawerma':
        return FoodCategory.shawerma;
      case 'Sandwiches':
        return FoodCategory.sandwiches;
      case 'Main Dishes':
        return FoodCategory.mainDishes;
      case 'Vegetarian Options':
        return FoodCategory.vegetarianOptions;
      case 'Desserts':
        return FoodCategory.desserts;
      case 'Extras':
        return FoodCategory.extras;
      default:
        throw Exception('Invalid FoodCategory value: $value');
    }
  }

  String get name {
    switch (this) {
      case FoodCategory.breakfast:
        return 'Breakfast';
      case FoodCategory.appetizers:
        return 'Appetizers';
      case FoodCategory.soups:
        return 'Soups';
      case FoodCategory.shawerma:
        return 'Shawerma';
      case FoodCategory.sandwiches:
        return 'Sandwiches';
      case FoodCategory.mainDishes:
        return 'Main Dishes';
      case FoodCategory.vegetarianOptions:
        return 'Vegetarian Options';
      case FoodCategory.desserts:
        return 'Desserts';
      case FoodCategory.extras:
        return 'Extras';
    }
  }

  String get icon {
    switch (this) {
      case FoodCategory.breakfast:
        return 'assets/icons/breakfast.svg'; // Coffee/breakfast icon
      case FoodCategory.appetizers:
        return 'assets/icons/appetizers.svg'; // Restaurant/appetizer icon
      case FoodCategory.soups:
        return 'assets/icons/soups.svg'; // Soup icon
      case FoodCategory.shawerma:
        return 'assets/icons/shawerma.svg'; // Kebab/shawerma icon
      case FoodCategory.sandwiches:
        return 'assets/icons/sandwiches.svg'; // Sandwich icon
      case FoodCategory.mainDishes:
        return 'assets/icons/maindishes.svg'; // Main dish icon
      case FoodCategory.vegetarianOptions:
        return 'assets/icons/veg.svg'; // Vegetarian/eco icon
      case FoodCategory.desserts:
        return 'assets/icons/dessert.svg'; // Dessert/cake icon
      case FoodCategory.extras:
        return 'assets/icons/extras.svg'; // Extras/more icon
    }
  }
}
