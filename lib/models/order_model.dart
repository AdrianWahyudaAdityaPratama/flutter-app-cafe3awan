class OrderItemModel {
  final int id;
  final int menuId;
  final int orderId;
  final double price;
  final int quantity;

  OrderItemModel({
    required this.id,
    required this.menuId,
    required this.orderId,
    required this.price,
    required this.quantity,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
    id: json['id'],
    menuId: json['menu_id'],
    orderId: json['order_id'],
    price: (json['price'] as num).toDouble(),
    quantity: json['quantity'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'menu_id': menuId,
    'order_id': orderId,
    'price': price,
    'quantity': quantity,
  };
}

class OrderModel {
  final int id;
  final String customerName;
  final List<OrderItemModel> items;
  final double totalPrice;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.customerName,
    required this.items,
    required this.totalPrice,
    required this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json['id'],
    customerName: json['customer_name'],
    totalPrice: (json['total_price'] as num).toDouble(),
    createdAt: DateTime.parse(json['created_at']),
    items: (json['items'] as List)
        .map((i) => OrderItemModel.fromJson(i))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'customer_name': customerName,
    'items': items.map((i) => i.toJson()).toList(),
    'total_price': totalPrice,
    'created_at': createdAt.toIso8601String(),
  };
}
