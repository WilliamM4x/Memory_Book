class MemoryObject {
  final String? id; // Optional ID for the memory object
  final String local;
  final String descricao;
  final String data;
  final List<String> localizacao;
  final List<String> imagens;

  MemoryObject({
    this.id,
    required this.local,
    required this.descricao,
    required this.data,
    required this.localizacao,
    required this.imagens,
  });
}