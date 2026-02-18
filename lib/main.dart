import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: const Color(0xFF0D47A1)
      ),
      home: const PantallaHerramientas(),
    );
  }
}

class PantallaHerramientas extends StatelessWidget {
  const PantallaHerramientas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tienda", style: TextStyle(color: Colors.white)), 
        backgroundColor: const Color(0xFF0D47A1)
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DetalleProducto(
                  nombre: "Foco LED Smart Pro",
                  precio: "\$12.50",
                  imagen: "https://raw.githubusercontent.com/Aaron-0330/IAMoviles-Act-10-Segunda-pantalla-dise-o/refs/heads/main/226670-d.jpg",
                  stock: 15,
                  descripcion: "Foco inteligente con control de temperatura de color y compatibilidad con asistentes de voz. Ideal para interiores y ahorro de energía eficiente para el hogar moderno.",
                ),
              ),
            );
          },
          child: const Text("Ver Producto (Ejemplo)"),
        ),
      ),
    );
  }
}

class DetalleProducto extends StatelessWidget {
  final String nombre;
  final String precio;
  final String imagen;
  final int stock;
  final String descripcion;

  const DetalleProducto({
    super.key,
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.stock,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    const Color azulOscuro = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: azulOscuro,
        title: const Text("Detalles", style: TextStyle(color: Colors.white)),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: azulOscuro,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: stock > 0 ? () {} : null,
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            label: const Text(
              "AÑADIR AL CARRITO", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- CONTENEDOR DE IMAGEN CORREGIDO ---
            Container(
              height: 350,
              width: double.infinity,
              color: Colors.white,
              child: Image.network(
                imagen,
                fit: BoxFit.contain,
                // Esto ayuda a manejar la carga en DartPad/Navegador
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(color: azulOscuro),
                  );
                },
                // Si el servidor de Home Depot bloquea la imagen, muestra esto:
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[100],
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_not_supported_outlined, size: 60, color: Colors.grey),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "La imagen no pudo ser cargada desde el servidor externo",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // ---------------------------------------

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(nombre, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      Text(precio, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: azulOscuro)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: stock > 0 ? Colors.green[50] : Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: stock > 0 ? Colors.green : Colors.red),
                    ),
                    child: Text(
                      stock > 0 ? "EN EXISTENCIA: $stock unidades" : "AGOTADO",
                      style: TextStyle(
                        color: stock > 0 ? Colors.green[700] : Colors.red[700], 
                        fontWeight: FontWeight.bold, 
                        fontSize: 12
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  const Text("ESPECIFICACIONES", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: 13, color: Colors.grey)),
                  const SizedBox(height: 10),
                  
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Text(
                      descripcion,
                      style: const TextStyle(color: Colors.black87, height: 1.5, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}