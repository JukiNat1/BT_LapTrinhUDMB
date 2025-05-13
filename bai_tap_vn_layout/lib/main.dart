import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FlutterDemoHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FlutterDemoHomePage extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Salcor Polo Shirt",
      "price": "\$4.50",
      "image":
          "https://images.pexels.com/photos/12724931/pexels-photo-12724931.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      "name": "Salcor T-Shirt",
      "price": "\$4.50",
      "image":
          "https://images.unsplash.com/photo-1581655353564-df123a1eb820?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80",
    },
    {
      "name": "Salcor Beanie",
      "price": "\$4.50",
      "image":
          "https://hatstore.imgix.net/4043898813556_1.jpg?auto=compress%2Cformat&w=350&h=280&fit=crop&q=80",
    },
    {
      "name": "Salcor Cup",
      "price": "\$4.50",
      "image":
          "https://images.pexels.com/photos/1235706/pexels-photo-1235706.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
    {
      "name": "Saleor Hoodie", // Đã thêm lại sản phẩm này
      "price": "\$4.50",
      "image":
          "https://images.pexels.com/photos/6311393/pexels-photo-6311393.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Products',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.8,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          padding: EdgeInsets.all(8),
                          child: Image.network(
                            products[index]["image"]!,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(child: Icon(Icons.broken_image));
                            },
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          products[index]["name"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          products[index]["price"]!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
