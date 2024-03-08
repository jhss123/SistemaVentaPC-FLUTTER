import 'package:flutter/material.dart';
import 'registrousuario.dart';
import 'registrorol.dart';
import 'registropermiso.dart';

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
      home: UsuariosAdmin(),
    );
  }
}

class UsuariosAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Administrar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade900,
      ),
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.content_paste, // Icono de formulario
              size: 130, // Tamaño del icono
              color: Colors.white, // Color del icono
            ),
            SizedBox(height: 70), // Separación entre icono y botón Usuarios
            SizedBox(
              width: 300, // Ancho del botón Usuarios
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroUser()),
                  );
                },
                icon: Icon(Icons.person),
                label: Text('Usuarios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 20), // Separación entre botones
            SizedBox(
              width: 300, // Ancho del botón Roles
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroRol()),
                  );
                },
                icon: Icon(Icons.group),
                label: Text('Roles'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
            SizedBox(height: 20), // Separación entre botones
            SizedBox(
              width: 300, // Ancho del botón Permisos
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroPermisos()),
                  );
                },
                icon: Icon(Icons.security),
                label: Text('Permisos'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
