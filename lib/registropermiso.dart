import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutterprogra4/admin.dart';
import 'package:flutterprogra4/UsuariosAdmin.dart';

//import 'package:flutterprogra4/main.dart';

class RegistroPermisos extends StatefulWidget {
  const RegistroPermisos({Key? key}) : super(key: key);

  @override
  _RegistroPermisosState createState() => _RegistroPermisosState();
}

class _RegistroPermisosState extends State<RegistroPermisos> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Permisos',
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
                            controller: nombreController,
                            decoration: InputDecoration(
                              labelText: 'Nombre',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu nombre';
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
                                return 'Por favor, ingresa el estado';
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
                        String nombre = nombreController.text;
                        String estado = estadoController.text;

                        // Consultar el último ID de usuario utilizado
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('permiso')
                            .orderBy('ID_Permiso', descending: true)
                            .limit(1)
                            .get();

                        int nuevoIdPermiso = 1;

                        if (querySnapshot.docs.isNotEmpty) {
                          nuevoIdPermiso =
                              querySnapshot.docs.first['ID_Permiso'] + 1;
                        }

                        // Crear un nuevo documento de usuario en Firestore con el ID generado
                        await FirebaseFirestore.instance
                            .collection('permiso')
                            .doc(nuevoIdPermiso.toString())
                            .set({
                          'ID_Permiso': nuevoIdPermiso,
                          'Nombre': nombre,
                          'Estado': estado,
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
                        nombreController.clear();
                        estadoController.clear();
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistroPermisos()),
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
