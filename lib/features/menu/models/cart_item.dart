import 'food_item.dart';

class CartItem {
  final FoodItem item;
  int _quantity;

  int get quantity => _quantity;

  void incrementQuantity() => _quantity++;

  void decrementQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }
  }

  CartItem({
    required this.item,
    int quantity = 1,
  }) : _quantity = quantity;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          _quantity == other._quantity);

  @override
  int get hashCode => item.hashCode ^ _quantity.hashCode;

  @override
  String toString() {
    return 'CartItem{' + ' item: $item,' + ' _quantity: $_quantity,' + '}';
  }

  CartItem copyWith({
    FoodItem? item,
    int? quantity,
  }) {
    return CartItem(
      item: item ?? this.item,
      quantity: quantity ?? this._quantity,
    );
  }
}
