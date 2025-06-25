import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_book/Models/memory_object.dart';

class MemoryService {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference memories = FirebaseFirestore.instance.collection('memories');

  //adicionar uma novo memory
  Future<String> addMemory(MemoryObject memory) async{
    var ref = await memories.add({
      'local': memory.local,
      'descricao': memory.descricao,
      'data': memory.data,
      'localizacao': memory.localizacao,
      'imagens': memory.imagens,
    });
    print(ref.id);
    return ref.id;
  }

  //pegar todo mundo na collection
  Future<List<MemoryObject>> getAll() async{
    List<MemoryObject> listaMemory = [];
    var querySnapshot = await memories.get();
    for (var doc in querySnapshot.docs) {
      var id = doc.id;
      var data = doc.data() as Map<String, dynamic>;
      data.addAll({"id": id});

      //criar método para isso
      MemoryObject memory = MemoryObject(
        id: data['id'],
        // transforma em string caso seja nulo  valor é: ''
        local: data['local'] as String? ?? '',
        descricao: data['descricao']as String? ?? '',
        data: data['data']as String? ?? '',
        localizacao: List<String>.from(data['localizacao'] ?? []),
        imagens: List<String>.from(data['imagens'] ?? []),
      );
      listaMemory.add(memory);
    }
    return listaMemory;
  }

}