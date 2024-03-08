import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutterprogra4/admin.dart';
import 'package:flutterprogra4/UsuariosAdmin.dart';

//import 'package:flutterprogra4/main.dart';

class RegistroRol extends StatefulWidget {
  const RegistroRol({Key? key}) : super(key: key);

  @override
  _RegistroRolState createState() => _RegistroRolState();
}

class _RegistroRolState extends State<RegistroRol> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();

  String? selectedPermisoId;
  List<Map<String, dynamic>> permisos = [];

  @override
  void initState() {
    super.initState();
    fetchPermisos();
  }

  void fetchPermisos() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('permiso').get();

      List<Map<String, dynamic>> fetchPermisos = [];
      querySnapshot.docs.forEach((doc) {
        fetchPermisos.add({
          'id': doc.id,
          'nombre': doc['Nombre'],
        });
      });

      setState(() {
        permisos = fetchPermisos;
      });
    } catch (e) {
      print('Error al obtener los permisos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Roles',
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
                          SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: selectedPermisoId,
                            decoration: InputDecoration(
                              labelText: 'Permiso',
                              prefixIcon: Icon(Icons.security),
                            ),
                            items: permisos.map((permisoss) {
                              return DropdownMenuItem<String>(
                                value: permisoss['id'],
                                child: Text(permisoss['nombre']),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPermisoId = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, selecciona un Permiso';
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

                        // Consultar el último ID de usuario utilizado
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('rol')
                            .orderBy('ID_Rol', descending: true)
                            .limit(1)
                            .get();

                        int nuevoIdUsuario = 1;

                        if (querySnapshot.docs.isNotEmpty) {
                          nuevoIdUsuario =
                              querySnapshot.docs.first['ID_Rol'] + 1;
                        }

                        // Crear un nuevo documento de usuario en Firestore con el ID generado
                        await FirebaseFirestore.instance
                            .collection('rol')
                            .doc(nuevoIdUsuario.toString())
                            .set({
                          'ID_Rol': nuevoIdUsuario,
                          'Nombre': nombre,
                          'ID_Permiso':
                              selectedPermisoId, // Usar el ID del rol seleccionado
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
                        setState(() {
                          selectedPermisoId =
                              null; // Limpiar el permiso seleccionado
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
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegistroRol()),
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
