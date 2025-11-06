class MenuItemModel {
  final String id;
  final String name;
  final String imageUrl;
  final double price;
  final String category;

  MenuItemModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  factory MenuItemModel.fromJson(Map<String, dynamic> json) => MenuItemModel(
    id: json['id'].toString(),
    name: json['name'],
    imageUrl: json['imageUrl'],
    price: (json['price'] as num).toDouble(),
    category: json['category'] ?? 'General',
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
    'price': price,
    'category': category,
  };
}
