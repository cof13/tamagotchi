import 'package:flutter/material.dart';

void main() {
  runApp(TamagotchiApp());
}

class TamagotchiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tamagotchi',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TamagotchiHomePage(),
    );
  }
}

class TamagotchiHomePage extends StatefulWidget {
  @override
  _TamagotchiHomePageState createState() => _TamagotchiHomePageState();
}

class _TamagotchiHomePageState extends State<TamagotchiHomePage> {
  String _estado = "Feliz"; // Estado del Tamagotchi
  int _hambre = 50; // Nivel de hambre (de 0 a 100)
  int _diversion = 50; // Nivel de diversión (de 0 a 100)

  // Métodos para interactuar con el Tamagotchi
  void alimentar() {
    setState(() {
      _hambre = (_hambre - 10).clamp(0, 100);
      _estado = "¡Lleno y feliz!";
    });
  }

  void jugar() {
    setState(() {
      _diversion = (_diversion + 10).clamp(0, 100);
      _estado = "¡Emocionado!";
    });
  }

  void actualizarEstado() {
    setState(() {
      if (_hambre >= 80) {
        _estado = "¡Hambriento y triste!";
      } else if (_diversion <= 20) {
        _estado = "Aburrido...";
      } else {
        _estado = "¡Feliz!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    actualizarEstado();
    return Scaffold(
      appBar: AppBar(
        title: Text('Tamagotchi', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Estado con fondo colorido
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Estado del Tamagotchi: $_estado',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            // Niveles de hambre y diversión
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Hambre: $_hambre', style: TextStyle(fontSize: 18, color: Colors.white)),
                SizedBox(width: 30),
                Text('Diversión: $_diversion', style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
            SizedBox(height: 30),
            // Botones interactivos con bordes redondeados
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: alimentar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Reemplazado 'primary' por 'backgroundColor'
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Alimentar", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: jugar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Reemplazado 'primary' por 'backgroundColor'
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text("Jugar", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
