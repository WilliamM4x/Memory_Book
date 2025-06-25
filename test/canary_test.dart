import 'package:test/test.dart';
//validar ambiente de testes unitário
//cuidado e não usar o import de widgets
void main(){
  group("Canary test",(){
    test("Canary test : retorna true se for true",(){

      expect(true, true);
    });
  });
}