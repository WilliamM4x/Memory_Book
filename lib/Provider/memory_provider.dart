import 'package:flutter/material.dart';
import 'package:memory_book/Models/memory_object.dart';

import '../Components/memory_item.dart';

class MemoryProvider with ChangeNotifier {
  List<MemoryObject> listaMemory = [];


  void saveMemory(MemoryObject memory) {
    listaMemory.add(memory);
    notifyListeners();
  }

  Widget gerarItemLista(int index){
    MemoryObject list = listaMemory[index];
    return MemoryItem(list);
  }

  void deleteMemory(MemoryObject value) {
    listaMemory.remove(value);
    notifyListeners();
  }


  MemoryObject edit(index){
    return listaMemory[index];
  }

}