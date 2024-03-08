import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutterprogra4/catalogo.dart';
//import 'package:flutterprogra4/Usuariosadmin.dart';
//import 'package:flutterprogra4/admin.dart';
import 'package:flutterprogra4/firebase_options.dart';
import 'registrocliente.dart'; // Importa tu archivo registro.dart
//import 'carrito.dart'; // Importa tu archivo carrito.dart
//import 'prueba.dart'; // Importa tu archivo prueba.dart
import 'admin.dart'; // Importa tu archivo admin.dart
import 'catalogo.dart'; // Importa tu archivo admin.dart
//import 'registrousuario.dart'; //Importa tu archivo registrousuario.dart
import 'registropedido.dart'; //Importa tu archivo registrousuario.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    FutureBuilder(
      // Espera la inicialización de Firebase
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se inicializa Firebase, muestra un contenedor de carga
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Si hay un error durante la inicialización, muestra un mensaje de error
          return ErrorWidget(snapshot.error! as Object);
        } else {
          // Cuando Firebase se inicializa correctamente, ejecuta la aplicación
          return MyApp();
        }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 58, 158, 183)),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showPassword = false; // Estado para mostrar/ocultar la contraseña

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade400,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "¡Hola! Bienvenido",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.shopping_cart, color: Colors.white, size: 30),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(30, 97, 221, 0.298),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: TextField(
                                controller:
                                    emailController, // Asigna el controlador al campo de texto
                                decoration: InputDecoration(
                                  hintText: "Correo Electronico",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade200),
                                ),
                              ),
                              child: TextField(
                                controller:
                                    passwordController, // Asigna el controlador al campo de texto
                                obscureText: !_showPassword,
                                decoration: InputDecoration(
                                  hintText: "Contraseña",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        onPressed: () async {
                          try {
                            // Obtener los valores ingresados por el usuario
                            String email = emailController.text;
                            String password = passwordController.text;

                            // Consultar el documento de usuario en Firestore
                            var querySnapshot = await FirebaseFirestore.instance
                                .collection('usuario')
                                .where('Correo_Electronico', isEqualTo: email)
                                .where('Contraseña', isEqualTo: password)
                                .limit(1)
                                .get();

                            // Verificar si se encontró un usuario con las credenciales proporcionadas
                            if (querySnapshot.docs.isNotEmpty) {
                              var userData = querySnapshot.docs.first.data();
                              // Obtener el ID de rol del usuario
                              String? roleId = userData['ID_Rol'];
                              if (roleId != null) {
                                // Redirigir a la página correspondiente según el rol del usuario
                                if (roleId == '1') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Admin(),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => catalogo(),
                                    ),
                                  );
                                }
                              } else {
                                // Mostrar un mensaje de error si el ID de rol no está disponible
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("Error de inicio de sesión"),
                                    content: Text(
                                        "No se pudo determinar el rol del usuario."),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } else {
                              // Mostrar un mensaje de error si no se encontró un usuario con las credenciales proporcionadas
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Error de inicio de sesión"),
                                  content: Text(
                                      "Correo electrónico o contraseña incorrectos."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            }
                            // Limpiar los campos del login después de guardar
                            emailController.clear();
                            passwordController.clear();
                          } catch (e) {
                            // Mostrar un mensaje de error si ocurre un error durante el inicio de sesión
                            print("Error de inicio de sesión: $e");
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("Error de inicio de sesión"),
                                content: Text(
                                    "Ha ocurrido un error.. Por favor, intenta nuevamente."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        height: 50,
                        color: Color.fromARGB(255, 0, 42, 230),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        "¡No tienes cuenta, Registrate!",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RegistroPage()), // Navega a la página de registro
                          );
                        },
                        height: 50,
                        color: Color.fromARGB(255, 0, 42, 230),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Text(
                        "Siguenos en nuestra Redes Sociales",
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Admin()), // Navega a la página de admin
                                );
                              },
                              height: 50,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  "Facebook",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistroPedido()), // Navega a la página de registrousuario
                                );
                              },
                              height: 50,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              color: Colors.black,
                              child: Center(
                                child: Text(
                                  "Github",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
