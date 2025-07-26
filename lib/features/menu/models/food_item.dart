import 'package:basic_restaurant_app/features/menu/models/food_category.dart';

class FoodItem {
  final String id;
  final String name;
  final double price;
  final String? imageUrl;
  final String? description;
  final FoodCategory category;

//<editor-fold desc="Data Methods">
  const FoodItem({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl,
    this.description,
    required this.category,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price &&
          imageUrl == other.imageUrl &&
          description == other.description &&
          category == other.category);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      imageUrl.hashCode ^
      description.hashCode ^
      category.hashCode;

  @override
  String toString() {
    return 'FoodItem{' +
        ' id: $id,' +
        ' name: $name,' +
        ' price: $price,' +
        ' imageUrl: $imageUrl,' +
        ' description: $description,' +
        ' category: $category,' +
        '}';
  }

  FoodItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    String? description,
    FoodCategory? category,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'category': category.name,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map, String id) {
    return FoodItem(
      id: id,
      name: map['name'] as String,
      price: map['price'] as double,
      imageUrl: map['imageUrl'] as String,
      description: map['description'] as String,
      category: FoodCategory.fromString(map['category']),
    );
  }

//</editor-fold>
}
