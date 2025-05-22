import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/memory_provider.dart';


class MemoryList extends StatelessWidget{

  //final List<MemoryObject> listaMemory;

  const MemoryList({super.key});



  @override
  Widget build(BuildContext context) {
    var providerMemory = Provider.of<MemoryProvider>(context, listen: true);

    return ListView.builder(
        shrinkWrap: true,
        itemCount: providerMemory.listaMemory.length,
        itemBuilder: (context, index){
          return providerMemory.gerarItemLista(index);
        }
    );


  }

}