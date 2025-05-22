import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Models/memory_object.dart';

class OnlyMemoryPage extends StatelessWidget{
//Na versão final quero apresentar a imagem do lugar, dia , descrição e localização
  @override
  Widget build(BuildContext context) {
    var memoryObject = ModalRoute.of(context)?.settings.arguments as MemoryObject;
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
              Text(memoryObject.imagens.toString()),
            ],
          ),
        ),
      ),

    );
  }

}