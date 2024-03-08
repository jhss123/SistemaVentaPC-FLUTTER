import 'package:flutter/material.dart';
import 'package:flutterprogra4/main.dart';
//import 'main.dart';
import 'carrito.dart';
import 'registropedido.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 158, 183)),
        useMaterial3: true,
      ),
      home: catalogo(),
    );
  }
}

class catalogo extends StatefulWidget {
  @override
  _CatalogoState createState() => _CatalogoState();
}

class _CatalogoState extends State<catalogo> {
  int _cartCount = 0;
  List<Product> _selectedProducts = [];
  List<Product> _allProducts = [
    Product(
      imagePath: 'assets/Imagenes/delll.png',
      productName: 'Portátil Dell',
      price: '\$2600 Bs',
    ),
    Product(
      imagePath: 'assets/Imagenes/hpp.png',
      productName: 'Portátil Hp',
      price: '\$2400 Bs',
    ),
    Product(
      imagePath: 'assets/Imagenes/mouse.png',
      productName: 'Mouse Inalámbrico',
      price: '\$600 Bs',
    ),
    Product(
      imagePath: 'assets/Imagenes/teclado.png',
      productName: 'Teclado',
      price: '\$900 Bs',
    ),
  ];

  List<Product> _filteredProducts = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = _allProducts;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _allProducts
          .where((product) =>
              product.productName.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void filterProducts(String category) {
    setState(() {
      if (category == 'Todos') {
        _filteredProducts = _allProducts;
      } else if (category == 'Portátiles') {
        _filteredProducts = _allProducts
            .where((product) => product.productName.contains('Portátil'))
            .toList();
      } else if (category == 'Accesorios') {
        _filteredProducts = _allProducts
            .where((product) =>
                product.productName.contains('Mouse') ||
                product.productName.contains('Teclado'))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            // Encabezado
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: IconButton(
                          icon: Icon(Icons.computer,
                              color: const Color.fromARGB(
                                  255, 255, 255, 255)), // Icono de color negro
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegistroPedido()), // Navega a la página de admin
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.search, color: Colors.black),
                                onPressed: () {},
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: 'Buscar...',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.shopping_cart, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartScreen(
                                      selectedProducts: _selectedProducts),
                                ),
                              );
                            },
                            iconSize: 35.0,
                          ),
                          if (_cartCount > 0)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.red,
                                child: Text(
                                  _cartCount.toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      filterProducts('Todos');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text('Todos'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      filterProducts('Portátiles');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text('Portátiles'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      filterProducts('Accesorios');
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text('Accesorios'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  children: [
                    // Columna izquierda
                    Expanded(
                      child: Column(
                        children: _filteredProducts
                            .asMap()
                            .entries
                            .where((entry) => entry.key % 2 == 0)
                            .map((entry) {
                          final product = entry.value;
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            child: _buildProductContainer(
                              product.imagePath,
                              product.productName,
                              product.price,
                              Icons.favorite_border,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    // Espacio entre columnas
                    SizedBox(width: 10),
                    // Columna derecha
                    Expanded(
                      child: Column(
                        children: _filteredProducts
                            .asMap()
                            .entries
                            .where((entry) => entry.key % 2 != 0)
                            .map((entry) {
                          final product = entry.value;
                          return Container(
                            padding: EdgeInsets.all(10.0),
                            child: _buildProductContainer(
                              product.imagePath,
                              product.productName,
                              product.price,
                              Icons.favorite_border,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage()), // Navega a la página de admin
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContainer(String imagePath, String productName,
      String price, IconData favoriteIcon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 160.0, // Ancho aumentado del contenedor del producto
      height: 250.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            productName,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain, // Imagen ajustada al contenedor
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _cartCount++;
                    _selectedProducts.add(Product(
                      imagePath: imagePath,
                      productName: productName,
                      price: price,
                    ));
                  });
                },
                icon: Icon(Icons.add_shopping_cart),
                label: Text('Añadir al carrito'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  minimumSize: Size(120, 36),
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(favoriteIcon),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
