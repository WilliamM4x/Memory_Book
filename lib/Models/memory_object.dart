class MemoryObject {
  final String? id;
  final String local;
  final String descricao;
  final String data;
  final String localizacao;
  final List<String> imagens;

  MemoryObject({
     this.id,
    required this.local,
    required this.descricao,
    required this.data,
    required this.localizacao,
    required this.imagens,
  });

  MemoryObject copyWith({
    String? id,
    String? local,
    String? descricao,
    String? data,
    String? localizacao,
    List<String>? imagens,
  }) {
    return MemoryObject(
      id: id ?? this.id,
      local: local ?? this.local,
      descricao: descricao ?? this.descricao,
      data: data ?? this.data,
      localizacao: localizacao ?? this.localizacao,
      imagens: imagens ?? this.imagens,
    );
  }

}