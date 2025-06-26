import 'package:flutter/material.dart';
import 'package:memory_book/Models/memory_object.dart';

import '../Components/memory_item.dart';
import '../Service/memory_service.dart';

class MemoryProvider with ChangeNotifier {
  final MemoryService _memoryService;
  List<MemoryObject> listaMemory = [];

  //entender melhor a injeção de dependência
  MemoryProvider(this._memoryService);
  MemoryProvider.empty() : _memoryService = MemoryService();


  Future<MemoryObject> getOneMemory(String id) async {
    MemoryObject? memory = await MemoryService().getOneMemory(id);
    if (memory != null) {
      return memory;
    } else {
      throw Exception("Memory not found");
    }
  }

  Future<void> saveMemory(MemoryObject memory) async{
      String id = await _memoryService.addMemory(memory);
      final memoryComID = memory.copyWith(id: id);
      try{listaMemory.add(memoryComID);
      } catch(e) {
        throw Exception("Erro ao adicionar memória: $e");
      } finally{
        notifyListeners();
      }
  }

  Future<void> updateMemory(MemoryObject memory) async {
    try{await _memoryService.updateMemory(memory);
    int index = listaMemory.indexOf(memory);
    listaMemory[index] = memory;
    }catch (e){
      throw Exception("Erro ao atualizar memória: $e");
    } finally{notifyListeners();}

  }

  Widget gerarItemLista(int index){
    MemoryObject list = listaMemory[index];
    return MemoryItem(list);
  }

  void deleteMemory(MemoryObject value) {
    _memoryService.deleteMemory(value.id!);
    listaMemory.remove(value);
    notifyListeners();
  }


}