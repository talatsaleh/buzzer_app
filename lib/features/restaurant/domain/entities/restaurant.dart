class Restaurant {
  final String id; // Unique ID
  final String name;
  final String address;
  final String imageUrl;
  final double rating; // Average rating

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rating,
  });

  factory Restaurant.fromMap(Map<String, dynamic> map,String newId) {
    return Restaurant(
      id: newId,
      name: map['name'],
      address: map['address'],
      imageUrl: map['imageUrl'],
      rating: map['rating'] as double,
    );
  }
}
