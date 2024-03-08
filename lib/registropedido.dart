import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutterprogra4/main.dart';
import 'package:flutterprogra4/Usuariosadmin.dart';

class RegistroPedido extends StatefulWidget {
  const RegistroPedido({Key? key}) : super(key: key);

  @override
  _RegistroPedidoState createState() => _RegistroPedidoState();
}

class _RegistroPedidoState extends State<RegistroPedido> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fechaController = TextEditingController();
  TextEditingController estadoController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  String? selectedProductoId;
  List<Map<String, dynamic>> productos = [];

  @override
  void initState() {
    super.initState();
    fetchProductos();
  }

  void fetchProductos() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('producto').get();

      List<Map<String, dynamic>> fetchProductos = [];
      querySnapshot.docs.forEach((doc) {
        fetchProductos.add({
          'id': doc.id,
          'nombre': doc['Nombre'],
        });
      });

      setState(() {
        productos = fetchProductos;
      });
    } catch (e) {
      print('Error al obtener los productos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Pedidos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue.shade900,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.person_outline,
                        size: 100,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: fechaController,
                            decoration: InputDecoration(
                              labelText: 'Fecha',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa la Fecha';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: estadoController,
                            decoration: InputDecoration(
                              labelText: 'Estado',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el Estado';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: totalController,
                            decoration: InputDecoration(
                              labelText: 'Total',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa el total';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: selectedProductoId,
                            decoration: InputDecoration(
                              labelText: 'Producto',
                              prefixIcon: Icon(Icons.account_circle),
                            ),
                            items: productos.map((productoss) {
                              return DropdownMenuItem<String>(
                                value: productoss['id'],
                                child: Text(productoss['nombre']),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedProductoId = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, selecciona un producto';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Obtener los valores ingresados por el usuario
                        String fecha = fechaController.text;
                        String estado = estadoController.text;
                        String total = totalController.text;

                        // Consultar el último ID de usuario utilizado
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('pedido')
                            .orderBy('ID_Pedido', descending: true)
                            .limit(1)
                            .get();

                        int nuevoIdPedido = 1;

                        if (querySnapshot.docs.isNotEmpty) {
                          nuevoIdPedido =
                              querySnapshot.docs.first['ID_Pedido'] + 1;
                        }

                        // Crear un nuevo documento de usuario en Firestore con el ID generado
                        await FirebaseFirestore.instance
                            .collection('pedido')
                            .doc(nuevoIdPedido.toString())
                            .set({
                          'ID_Pedido': nuevoIdPedido,
                          'Fecha': fecha,
                          'Estado': estado,
                          'Total': total,
                          'ID_Producto':
                              selectedProductoId, // Usar el ID del rol seleccionado
                        });

                        // Mostrar un mensaje de éxito
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Registro Exitoso"),
                            content: Text(
                                "¡El registro se ha completado con éxito!"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UsuariosAdmin()),
                                  );
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ),
                            ],
                          ),
                        );

                        // Limpiar los campos del formulario después de guardar
                        fechaController.clear();
                        estadoController.clear();
                        totalController.clear();
                        setState(() {
                          selectedProductoId =
                              null; // Limpiar el rol seleccionado
                        });
                      } catch (e) {
                        print("Error de registro: $e");
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Error de registro"),
                            content: Text(
                              "Ha ocurrido un error durante el registro. Por favor, intenta nuevamente.",
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 248, 248, 248),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(130, 50),
                  ),
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Color.fromARGB(255, 32, 85, 134)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
