import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../Models/memory_object.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

class OnlyMemoryPage extends StatefulWidget {
  const OnlyMemoryPage({super.key});

  @override
  State<OnlyMemoryPage> createState() => _OnlyMemoryPageState();
}

class _OnlyMemoryPageState extends State<OnlyMemoryPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(-12.251972442537367, -38.941292755999314);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var memoryObject =
        ModalRoute.of(context)?.settings.arguments as MemoryObject;

    final Set<Marker> _markers = {};

    void _onMapCreated(GoogleMapController controller) {
        _markers.clear();
        final double lat = double.parse(memoryObject.localizacao[0]);
        final double lng = double.parse(memoryObject.localizacao[1]);
        // 2. Criar o objeto LatLng com os valores convertidos
        final position = LatLng(lat, lng);
          final marker = Marker(
            markerId: MarkerId(memoryObject.local),
            position: position,
            infoWindow: InfoWindow(
              title: memoryObject.local,
              snippet: memoryObject.descricao,
            ),
          );
        setState(() {_markers.add(marker);});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Veja o seu dia'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(memoryObject.local),
              Text(memoryObject.descricao),
              Text(memoryObject.data.toString()),
              Text(memoryObject.localizacao.toString()),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child:
                    memoryObject.imagens.isEmpty
                        ? const Center(
                          child: Text('Nenhuma imagem selecionada'),
                        )
                        : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: memoryObject.imagens.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              // Exibe a imagem a partir do arquivo local
                              child: Image.file(
                                File(memoryObject.imagens[index]),
                              ),
                            );
                          },
                        ),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.all(16.0,), // Adiciona uma margem em volta do container
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueGrey, // Cor da borda
                    width: 3, // Largura da borda
                  ),
                  borderRadius: BorderRadius.circular(12), // Cantos arredondados
                  boxShadow: [
                    // Sombra para dar um efeito de elevação
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                // ClipRRect para que o mapa também tenha os cantos arredondados
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9.0,), // Deve ser um pouco menor que o do container
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(target: _center, zoom: 5.0),
                    markers: _markers,
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
