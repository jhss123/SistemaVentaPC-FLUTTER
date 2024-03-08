import 'package:flutter/material.dart';
import 'main.dart';
import 'Usuariosadmin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 158, 183)),
        useMaterial3: true,
      ),
      home: Admin(),
    );
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black, // Color de fondo negro
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.black), // Borde negro
              ),
              child: Column(
                children: [
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            // Mostrar cuadro de diálogo personalizado
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.arrow_back,
                                                color: Colors
                                                    .black), // Icono de color negro
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          Text(
                                            'Registros',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors
                                                  .black, // Texto de color negro
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.0),
                                      ListTile(
                                        title: Text('Usuarios',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UsuariosAdmin()), // Navega a la página de registro
                                          ); // Acción al seleccionar Usuarios
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Productos',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                        onTap: () {
                                          // Acción al seleccionar Roles
                                        },
                                      ),
                                      ListTile(
                                        title: Text('Proveedores',
                                            style: TextStyle(
                                              color: Colors.black,
                                            )),
                                        onTap: () {
                                          // Acción al seleccionar Permisos
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.work,
                            size: 30.0,
                            color: Colors.white, // Icono de color blanco
                          ),
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
                                icon: Icon(Icons.search,
                                    color:
                                        Colors.black), // Icono de color negro
                                onPressed: () {},
                              ),
                              Expanded(
                                child: TextField(
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
                      IconButton(
                        icon: Icon(Icons.shopping_cart,
                            color: Color(0xfff9f8f8)), // Icono de color blanco
                        onPressed: () {},
                        iconSize: 35.0,
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
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      )),
                    ),
                    child: Text('Todos'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      )),
                    ),
                    child: Text('Portátiles'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.black),
                      )),
                    ),
                    child: Text('Accesorios'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildProductContainer(
                            3,
                            'assets/Imagenes/delll.png',
                            'Portátil Dell',
                            '\$1200',
                            Icons.shopping_cart,
                            Icons.favorite_border,
                          ),
                          _buildProductContainer(
                            2,
                            'assets/Imagenes/delll.png',
                            'Portátil Dell',
                            '\$1200',
                            Icons.shopping_cart,
                            Icons.favorite_border,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildProductContainer(
                            3,
                            'assets/Imagenes/delll.png',
                            'Portátil Dell',
                            '\$1200',
                            Icons.shopping_cart,
                            Icons.favorite_border,
                          ),
                          _buildProductContainer(
                            4,
                            'assets/Imagenes/delll.png',
                            'Portátil Dell',
                            'Precio: '
                                '\$1200',
                            Icons.shopping_cart,
                            Icons.favorite_border,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black, // Color de fondo negro
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.home,
                        color: Colors.white), // Icono de color blanco
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite,
                        color: Colors.white), // Icono de color blanco
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle,
                        color: Colors.white), // Icono de color blanco
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductContainer(int index, String imagePath, String productName,
      String price, IconData cartIcon, IconData favoriteIcon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      width: 150.0,
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
              child: Container(
                constraints: BoxConstraints(maxWidth: 120.0),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Icon(
                  cartIcon,
                  color: Colors.black,
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  )),
                ),
              ),
              IconButton(
                icon: Icon(
                  favoriteIcon,
                  color: Colors.black,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
