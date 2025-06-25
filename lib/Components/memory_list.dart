import 'package:flutter/material.dart';
import 'package:memory_book/Service/memory_service.dart';
import 'package:provider/provider.dart';
import '../Provider/memory_provider.dart';


class MemoryList extends StatelessWidget{

  const MemoryList({super.key});

  @override
  Widget build(BuildContext context) {
    var providerMemory = Provider.of<MemoryProvider>(context, listen: true);

    // return ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: providerMemory.listaMemory.length,
    //     itemBuilder: (context, index){
    //       return providerMemory.gerarItemLista(index);
    //     }
    // );
    return FutureBuilder(
        future: MemoryService().getAll(),
        builder: (context, snapshot){
          if (snapshot.connectionState== ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError){
            return Center(
              child: Text('Erro ao carregar as memórias: ${snapshot.error}'),
            );
          }else{
            providerMemory.listaMemory = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: providerMemory.listaMemory.length,
                itemBuilder: (context, index){
                  return providerMemory.gerarItemLista(index);
                }
            );
          }
        });
  }

}