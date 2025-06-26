import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memory_book/Models/memory_object.dart';

class MemoryService {

  CollectionReference memories = FirebaseFirestore.instance.collection('memories');

  //get id
  Future<String?> getId(MemoryObject memory) async{
    return memory.id;
  }
  //deletar uma memory
  Future<void> deleteMemory(String id) async {
    await memories.doc(id).delete();
  }
  //pegar um produto específico
  Future<MemoryObject?> getOneMemory(String id) async {
    var doc = await memories.doc(id).get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      data.addAll({'id':id});
      return MemoryObject(
        id: data['id'],
        local: data['local'] as String? ?? '',
        descricao: data['descricao'] as String? ?? '',
        data: data['data'] as String? ?? '',
        localizacao: List<String>.from(data['localizacao'] ?? []),
        imagens: List<String>.from(data['imagens'] ?? []),
      );
    }
    return null;
  }
  //atualizar uma memory
  Future<void> updateMemory(MemoryObject memory) async {
    if(memory.id != null){
      await memories.doc(memory.id.toString()).update({
        'local': memory.local,
        'descricao': memory.descricao,
        'data': memory.data,
        'localizacao': memory.localizacao,
        'imagens': memory.imagens,
      });
    }else{
      throw Exception("Memory ID is null, cannot update.");
    }

  }
  //adicionar uma nova memory
  Future<String> addMemory(MemoryObject memory) async{
    var ref = await memories.add({
      'local': memory.local,
      'descricao': memory.descricao,
      'data': memory.data,
      'localizacao': memory.localizacao,
      'imagens': memory.imagens,
    });
    return ref.id;
  }
  //pegar todos documentos da collection
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