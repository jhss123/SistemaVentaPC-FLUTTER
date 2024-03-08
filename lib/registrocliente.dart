import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterprogra4/main.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({Key? key}) : super(key: key);

  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController carnetController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro de Usuario',
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
                          TextFormField(
                            controller: apellidoController,
                            decoration: InputDecoration(
                              labelText: 'Apellido',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu apellido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: carnetController,
                            decoration: InputDecoration(
                              labelText: 'Carnet Identidad',
                              prefixIcon: Icon(Icons.credit_card),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu carné de identidad';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: telefonoController,
                            decoration: InputDecoration(
                              labelText: 'Teléfono',
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu número de teléfono';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: direccionController,
                            decoration: InputDecoration(
                              labelText: 'Dirección',
                              prefixIcon: Icon(Icons.location_on),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu dirección';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: 'Correo Electrónico',
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu correo electrónico';
                              } else if (!value.contains('@')) {
                                return 'Por favor, ingresa un correo electrónico válido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(
                                  _showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                            ),
                            obscureText: !_showPassword,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, ingresa tu contraseña';
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
                        String apellido = apellidoController.text;
                        String carnet = carnetController.text;
                        String telefono = telefonoController.text;
                        String direccion = direccionController.text;
                        String email = emailController.text;
                        String password = passwordController.text;

                        // Consultar el último ID de usuario utilizado
                        var querySnapshot = await FirebaseFirestore.instance
                            .collection('usuario')
                            .orderBy('ID_Usuario', descending: true)
                            .limit(1)
                            .get();

                        int nuevoIdUsuario = 1;

                        if (querySnapshot.docs.isNotEmpty) {
                          nuevoIdUsuario =
                              querySnapshot.docs.first['ID_Usuario'] + 1;
                        }

                        // Crear un nuevo documento de usuario en Firestore con el ID generado
                        await FirebaseFirestore.instance
                            .collection('usuario')
                            .doc(nuevoIdUsuario.toString())
                            .set({
                          'ID_Usuario': nuevoIdUsuario,
                          'Nombre': nombre,
                          'Apellido': apellido,
                          'Carnet_Identidad': carnet,
                          'Telefono': telefono,
                          'Direccion_Envio': direccion,
                          'Correo_Electronico': email,
                          'Contraseña': password,
                          'ID_Rol':
                              '2', // Establecer el ID de rol como "Cliente"
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
                                        builder: (context) => HomePage()),
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
                        apellidoController.clear();
                        carnetController.clear();
                        telefonoController.clear();
                        direccionController.clear();
                        emailController.clear();
                        passwordController.clear();
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
