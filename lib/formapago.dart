import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario de Pago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormaPago(),
    );
  }
}

class FormaPago extends StatefulWidget {
  @override
  _FormaPagoState createState() => _FormaPagoState();
}

class _FormaPagoState extends State<FormaPago> {
  String? _selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Elija el método de pago'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.blue.shade900,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.content_paste, // Icono de formulario
                  size: 130, // Tamaño del icono
                  color: Colors.white, // Color del icono
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPaymentMethod = 'Tarjeta';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 60), // Tamaño mínimo del botón
                  ),
                  child: Text('Pagar con Tarjeta'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _selectedPaymentMethod = 'PayPal';
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(350, 60), // Tamaño mínimo del botón
                  ),
                  child: Text('Pagar con PayPal'),
                ),
                SizedBox(height: 20),
                if (_selectedPaymentMethod != null)
                  _selectedPaymentMethod == 'Tarjeta'
                      ? TarjetaForm()
                      : PayPalForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TarjetaForm extends StatefulWidget {
  @override
  _TarjetaFormState createState() => _TarjetaFormState();
}

class _TarjetaFormState extends State<TarjetaForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController numeroController = TextEditingController();
  TextEditingController titularController = TextEditingController();
  TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de la Tarjeta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: numeroController,
              decoration: InputDecoration(
                labelText: 'Número de Tarjeta',
                prefixIcon: Icon(Icons.credit_card),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el número de la tarjeta';
                }
                return null;
              },
            ),
            TextFormField(
              controller: titularController,
              decoration: InputDecoration(
                labelText: 'Titular de la Tarjeta',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese el titular de la tarjeta';
                }
                return null;
              },
            ),
            TextFormField(
              controller: fechaController,
              decoration: InputDecoration(
                labelText: 'Fecha de Vencimiento',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese la fecha de vencimiento';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Guardar datos en Firebase
                  try {
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection('tarjeta')
                        .get();

                    int nuevoIdTarjeta = querySnapshot.docs.length + 1;

                    await FirebaseFirestore.instance
                        .collection('tarjeta')
                        .doc(nuevoIdTarjeta.toString())
                        .set({
                      'ID_Tarjeta': nuevoIdTarjeta,
                      'NumeroTarjeta': numeroController.text,
                      'Titular': titularController.text,
                      'FechaVencimiento': fechaController.text,
                    });

                    // Mostrar mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tarjeta registrada con éxito'),
                      ),
                    );

                    // Limpiar los campos
                    numeroController.clear();
                    titularController.clear();
                    fechaController.clear();
                  } catch (e) {
                    print('Error al guardar la tarjeta: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al guardar la tarjeta'),
                      ),
                    );
                  }
                }
              },
              child: Text('Confirmar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Tamaño mínimo del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PayPalForm extends StatefulWidget {
  @override
  _PayPalFormState createState() => _PayPalFormState();
}

class _PayPalFormState extends State<PayPalForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController correoController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Información de PayPal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: correoController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su correo electrónico';
                }
                return null;
              },
            ),
            TextFormField(
              controller: contrasenaController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su contraseña';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Guardar datos en Firebase
                  try {
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection('paypal')
                        .get();

                    int nuevoIdPayPal = querySnapshot.docs.length + 1;

                    await FirebaseFirestore.instance
                        .collection('paypal')
                        .doc(nuevoIdPayPal.toString())
                        .set({
                      'ID_Paypal': nuevoIdPayPal,
                      'Correo': correoController.text,
                      'Contraseña': contrasenaController.text,
                    });

                    // Mostrar mensaje de éxito
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Compra Realizada con Éxito'),
                      ),
                    );

                    // Limpiar los campos
                    correoController.clear();
                    contrasenaController.clear();
                  } catch (e) {
                    print('Error al guardar la cuenta de PayPal: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al guardar la cuenta de PayPal'),
                      ),
                    );
                  }
                }
              },
              child: Text('Confirmar'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), // Tamaño mínimo del botón
              ),
            ),
          ],
        ),
      ),
    );
  }
}
