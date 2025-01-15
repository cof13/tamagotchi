import 'package:flutter/material.dart';
import 'dart:async';

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
  int _energia = 50; // Nivel de energía (de 0 a 100)
  int _limpieza = 50; // Nivel de limpieza (de 0 a 100)
  String _mascotaSeleccionada =
      "assets/dino.png"; // Imagen de la mascota seleccionada

  // Lista de mascotas disponibles
  final List<Map<String, String>> _catalogoMascotas = [
    {"nombre": "Dinosaurio", "imagen": "assets/dino.png"},
    {"nombre": "Perrito", "imagen": "assets/perro.png"},
    {"nombre": "Conejo", "imagen": "assets/cone.png"},
    {"nombre": "Tortuga", "imagen": "assets/tortuga.png"},
    {"nombre": "Serpiente", "imagen": "assets/serpiente.png"},
  ];

  // Temporizador para actualizar el estado
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 120), (timer) {
      setState(() {
        _hambre = (_hambre + 120).clamp(0, 100);
        _diversion = (_diversion - 120).clamp(0, 100);
        _energia = (_energia - 120).clamp(0, 100);
        _limpieza = (_limpieza - 120).clamp(0, 100);
      });
      actualizarEstado();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

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

  void dormir() {
    setState(() {
      _energia = (_energia + 20).clamp(0, 100);
      _estado = "¡Descansado!";
    });
  }

  void limpiar() {
    setState(() {
      _limpieza = (_limpieza + 20).clamp(0, 100);
      _estado = "¡Limpio y fresco!";
    });
  }

  void actualizarEstado() {
    setState(() {
      if (_hambre >= 80) {
        _estado = "¡Hambriento y triste!";
      } else if (_diversion <= 20) {
        _estado = "Aburrido...";
      } else if (_energia <= 20) {
        _estado = "Cansado...";
      } else if (_limpieza <= 20) {
        _estado = "¡Sucio!";
      } else {
        _estado = "¡Feliz!";
      }
    });
  }

  void seleccionarMascota(String nuevaMascota) {
    setState(() {
      _mascotaSeleccionada = nuevaMascota;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tamagotchi',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
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
          children: [
            // Mostrar la mascota seleccionada
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _mascotaSeleccionada,
                    height: screenWidth > 600 ? 200 : 150,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Estado del Tamagotchi: $_estado',
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 28 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    children: [
                      Text(
                        'Hambre: $_hambre',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        'Diversión: $_diversion',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        'Energía: $_energia',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        'Limpieza: $_limpieza',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Botones interactivos
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: alimentar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 40 : 20, vertical: 15),
                  ),
                  child: Text(
                    "Alimentar",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 14,
                      color: Colors.white, // Color del texto blanco
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: jugar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 40 : 20, vertical: 15),
                  ),
                  child: Text(
                    "Jugar",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 14,
                      color: Colors.white, // Color del texto blanco
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: dormir,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 173, 120, 182),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 40 : 20, vertical: 15),
                  ),
                  child: Text(
                    "Dormir",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 14,
                      color: Colors.white, // Color del texto blanco
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: limpiar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: screenWidth > 600 ? 40 : 20, vertical: 15),
                  ),
                  child: Text(
                    "Limpiar",
                    style: TextStyle(
                      fontSize: screenWidth > 600 ? 20 : 14,
                      color: Colors.white, // Color del texto blanco
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Catálogo de mascotas
            SizedBox(
              height: screenWidth > 600 ? 150 : 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _catalogoMascotas.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      seleccionarMascota(_catalogoMascotas[index]['imagen']!);
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          _catalogoMascotas[index]['imagen']!,
                          width: screenWidth > 600 ? 100 : 60,
                          height: screenWidth > 600 ? 100 : 60,
                        ),
                        SizedBox(height: 5),
                        Text(
                          _catalogoMascotas[index]['nombre']!,
                          style: TextStyle(
                            fontSize: screenWidth > 600 ? 16 : 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
