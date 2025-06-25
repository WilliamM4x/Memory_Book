
import 'package:passwordtest/passwordtest.dart';
import 'package:test/test.dart';

main(){

  group("Testando a validação de senha", (){
    //instânciando o pacote de validação de senha
    PassTest verifyPassword = PassTest();

    test('Senha invalida', (){
      String password = "123456";

      FeedbackStrongPass forcaSenha=verifyPassword.checarForca(password);

      expect(forcaSenha, FeedbackStrongPass.invalida);
    });
    test('Senha fraca', (){
      String password = "12345678w";

      FeedbackStrongPass forcaSenha=verifyPassword.checarForca(password);

      expect(forcaSenha, FeedbackStrongPass.fraca);
    });
    test('Senha moderada', (){
      String password = "12345678wE";

      FeedbackStrongPass forcaSenha=verifyPassword.checarForca(password);

      expect(forcaSenha, FeedbackStrongPass.moderada);
    });
    test('Senha forte', (){
      String password = "12345678wE@";

      FeedbackStrongPass forcaSenha=verifyPassword.checarForca(password);

      expect(forcaSenha, FeedbackStrongPass.forte);
    });
  });
}