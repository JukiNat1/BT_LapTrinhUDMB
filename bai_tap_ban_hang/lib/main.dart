import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sản phẩm',
      home: Scaffold(
        appBar: AppBar(title: Text('Sản phẩm')),
        body: ProductGrid(),
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      "name": "Màn hình",
      "price": 3200000,
      "image":
          "https://images.unsplash.com/photo-1593642632823-8f785ba67e45?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Tai nghe",
      "price": 250000,
      "image":
          "https://images.pexels.com/photos/205926/pexels-photo-205926.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
    {
      "name": "Chuột",
      "price": 180000,
      "image":
          "https://images.pexels.com/photos/2115256/pexels-photo-2115256.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
    {
      "name": "Bàn phím",
      "price": 850000,
      "image":
          "https://images.pexels.com/photos/1772123/pexels-photo-1772123.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
    {
      "name": "Màn hình",
      "price": 3200000,
      "image":
          "https://images.pexels.com/photos/1714208/pexels-photo-1714208.jpeg?auto=compress&cs=tinysrgb&w=500",
    },
    {
      "name": "Tai nghe",
      "price": 250000,
      "image":
          "https://images.unsplash.com/photo-1546435770-a3e426bf472b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Chuột",
      "price": 180000,
      "image":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Bàn phím",
      "price": 850000,
      "image":
          "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Tai nghe",
      "price": 250000,
      "image":
          "https://images.unsplash.com/photo-1546435770-a3e426bf472b?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Chuột",
      "price": 180000,
      "image":
          "https://images.unsplash.com/photo-1600585154340-be6161a56a0c?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
    {
      "name": "Bàn phím",
      "price": 850000,
      "image":
          "https://images.unsplash.com/photo-1600585154526-990dced4db0d?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=60",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      padding: EdgeInsets.all(8),
      children:
          products.map((product) {
            return Container(
              color: Colors.teal[50],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(product['image'], height: 100, width: 100),
                  SizedBox(height: 8),
                  Text(
                    product['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${product['price']} VND'),
                ],
              ),
            );
          }).toList(),
    );
  }
}
