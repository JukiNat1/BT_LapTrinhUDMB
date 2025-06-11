import 'dart:convert';

void main() {
  // JSON string
  String jsonString = '''
  {
    "user": {
      "id": 1,
      "name": "Nguyễn Văn A",
      "email": "vana@example.com",
      "address": {
        "street": "123 Đường A",
        "city": "Hà Nội",
        "zipcode": "100000"
      },
      "orders": [
        {
          "id": 101,
          "product": "Laptop",
          "price": 15000000
        },
        {
          "id": 102,
          "product": "Chuột không dây",
          "price": 500000
        }
      ]
    }
  }
  ''';

  // Parse JSON
  Map<String, dynamic> data = jsonDecode(jsonString);

  // Lấy thông tin user
  Map<String, dynamic> user = data['user'];

  // In ra thông tin yêu cầu
  print('Tên người dùng: ${user['name']}');
  print('Thành phố: ${user['address']['city']}');
  print('Danh sách sản phẩm đã mua:');

  // Lặp qua danh sách orders
  List<dynamic> orders = user['orders'];
  for (var order in orders) {
    // Format giá tiền với dấu phẩy
    String formattedPrice = formatPrice(order['price']);
    print('- ${order['product']} - ${formattedPrice} VNĐ');
  }
}

// Hàm format giá tiền
String formatPrice(int price) {
  String priceStr = price.toString();
  String formatted = '';

  for (int i = 0; i < priceStr.length; i++) {
    if (i > 0 && (priceStr.length - i) % 3 == 0) {
      formatted += ',';
    }
    formatted += priceStr[i];
  }

  return formatted;
}

class User {
  final int id;
  final String name;
  final String email;
  final Address address;
  final List<Order> orders;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.orders,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      address: Address.fromJson(json['address']),
      orders:
          (json['orders'] as List)
              .map((order) => Order.fromJson(order))
              .toList(),
    );
  }
}

class Address {
  final String street;
  final String city;
  final String zipcode;

  Address({required this.street, required this.city, required this.zipcode});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      city: json['city'],
      zipcode: json['zipcode'],
    );
  }
}

class Order {
  final int id;
  final String product;
  final int price;

  Order({required this.id, required this.product, required this.price});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      product: json['product'],
      price: json['price'],
    );
  }
}

// Sử dụng với class:
void useWithClass() {
  String jsonString = '''
  {
    "user": {
      "id": 1,
      "name": "Nguyễn Văn A",
      "email": "vana@example.com",
      "address": {
        "street": "123 Đường A",
        "city": "Hà Nội",
        "zipcode": "100000"
      },
      "orders": [
        {
          "id": 101,
          "product": "Laptop",
          "price": 15000000
        },
        {
          "id": 102,
          "product": "Chuột không dây",
          "price": 500000
        }
      ]
    }
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonString);
  User user = User.fromJson(data['user']);

  print('Tên người dùng: ${user.name}');
  print('Thành phố: ${user.address.city}');
  print('Danh sách sản phẩm đã mua:');

  for (var order in user.orders) {
    String formattedPrice = formatPrice(order.price);
    print('- ${order.product} - ${formattedPrice} VNĐ');
  }
}
