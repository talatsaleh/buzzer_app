class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rate;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rate,
  });

  factory MenuItem.fromMap(Map<String, dynamic> map, String newId) {
    return MenuItem(
      id: newId,
      name: map['name'],
      description: map['description'],
      price: double.parse('${map['price']}'),
      imageUrl: map['imageUrl'],
      rate: double.parse('${map['rate']}'),
    );
  }
}
