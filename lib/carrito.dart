import 'package:flutter/material.dart';
import 'formapago.dart';

class Product {
  final String imagePath;
  final String productName;
  final String price;
  int quantity;

  Product({
    required this.imagePath,
    required this.productName,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  final List<Product> selectedProducts;

  CartScreen({required this.selectedProducts});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double calculateTotal() {
    double total = 0;
    for (var product in widget.selectedProducts) {
      final priceWithoutSymbol = product.price.replaceAll(' Bs', '');
      final priceNumeric = double.parse(priceWithoutSymbol.substring(1));
      total += priceNumeric * product.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: ListView.builder(
        itemCount: widget.selectedProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(widget.selectedProducts[index].imagePath),
            title: Text(widget.selectedProducts[index].productName),
            subtitle: Row(
              children: [
                Text(widget.selectedProducts[index].price),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (widget.selectedProducts[index].quantity > 1) {
                              widget.selectedProducts[index].quantity--;
                            }
                          });
                        },
                      ),
                      Text(
                        widget.selectedProducts[index].quantity.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.selectedProducts[index].quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  widget.selectedProducts.removeAt(index);
                });
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total: \$${calculateTotal().toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.selectedProducts.clear();
                });
              },
              child: Text('Vaciar Carrito'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormaPago()),
                );
              },
              child: Text('Realizar Compra'),
            ),
          ],
        ),
      ),
    );
  }
}
