import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_book/Pages/login_page.dart';
import 'package:memory_book/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

Widget testLoginPage() => ChangeNotifierProvider(
  create: (context) => AuthProvider(),
  child: MaterialApp(
    home: LoginPage(),
  )
);

main(){
  group("Testes da tela de login", (){
    testWidgets("Email e senha vazios sobe note", (tester) async{
        await tester.pumpWidget(testLoginPage());

        final buttonFinder = find.byWidgetPredicate(
                (widget)=> widget is ElevatedButton
                    && widget.child is Text &&(widget.child as Text).data == 'Login');

        await tester.tap(buttonFinder);
        await tester.pump();

        expect(find.text('Preencha o email e a senha.'), findsOneWidget);
    });
    testWidgets("Email ou senha errados ou sem cadastro sobe note", (tester) async{
      await tester.pumpWidget(testLoginPage());

      final emailFinder = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.labelText == 'E-mail');
      final senhaFinder = find.byWidgetPredicate(
          (widget) => widget is TextField && widget.decoration?.labelText == 'Senha');
      final buttonFinder = find.byWidgetPredicate(
              (widget)=> widget is ElevatedButton
              && widget.child is Text &&(widget.child as Text).data == 'Login');
      await tester.enterText(emailFinder, "tes@g.com");
      await tester.enterText(senhaFinder, "1234");
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(find.text("Error.400! Verifique seus dados ou realize o cadastro."), findsOneWidget);
    });
    // testWidgets("Navega para cadastro/ login sucesso", (tester) async{
    // Preciso de um MOCK e eu não entendi o conseito de MOCK ainda.
    //   await tester.pumpWidget(testLoginPage());
    //
    //   await tester.tap(find.text('Cadastro'));
    //   await tester.pump();
    //
    //   expect(find.text('Registro'), findsOneWidget);
    // });
  });
}