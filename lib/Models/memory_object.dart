class MemoryObject {
  final String local;
  final String descricao;
  final String data;
  final List<String> localizacao;
  final List<String> imagens;

  MemoryObject({
    required this.local,
    required this.descricao,
    required this.data,
    required this.localizacao,
    required this.imagens,
  });
}