class CartItem {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final double rate;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.restaurantId,
    required this.restaurantName,
    required this.rate,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'imageUrl': imageUrl,
      'rate': rate,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      restaurantId: map['restaurantId'],
      restaurantName: map['restaurantName'],
      rate: map['rate'],
      imageUrl: map['imageUrl'],
    );
  }

  double get total => quantity * price;
}
