import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memory_book/Pages/register_page.dart';

main(){
    group("Teste dos widgets na tela de registro", (){
      testWidgets("Testando senhas nao coincidentes", (tester) async {
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        // Usar `find.byWidgetPredicate` é mais robusto para encontrar TextFields específicos
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );
        final confirmaSenhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Confirme Senha',
        );

        await tester.enterText(senhaFinder, "12345678Wo@");
        await tester.enterText(confirmaSenhaFinder, "123456");
        await tester.tap(find.text('Registrar')); //childe do botãp
        await tester.pump(); // Diz ao Flutter: "reconstrua a tela agora!"

        expect(find.text("As senhas não coincidem"), findsOneWidget);


      });
      testWidgets("Testando campo confirme senha vazio", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );
        final confirmaSenhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Confirme Senha',
        );


        //actio
        await tester.enterText(senhaFinder, "12345678@e");
        await tester.enterText(confirmaSenhaFinder, "");
        await tester.tap(find.text('Registrar'));
        await tester.pumpAndSettle();

        expect(find.text("Confirme sua senha"), findsOneWidget);
      });
      testWidgets("Testando botao desabilitado com senha invalida", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );

        //actio
        await tester.enterText(senhaFinder, "12345678");
        await tester.pumpAndSettle();


        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.onPressed, isNull);
      });
      testWidgets("Testando mensagens de senha invalida", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );

        //action
        await tester.enterText(senhaFinder, "1234567");
        await tester.pump();

        expect(find.text("A senha precisa ter 8 caracteres ou mais."), findsOneWidget);
      });

      testWidgets("Testando mensagens de senha fraca", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );

        //actio
        await tester.enterText(senhaFinder, "12345678ww");
        await tester.pumpAndSettle();

        expect(find.text("Senha fraca."), findsOneWidget);
      });

      testWidgets("Testando mensagens de senha moderada", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );

        //actio
        await tester.enterText(senhaFinder, "12345678wwW");
        await tester.pumpAndSettle();

        expect(find.text("Senha moderada."), findsOneWidget);
      });

      testWidgets("Testando mensagens de senha forte", (tester) async{
        //instanciando
        await tester.pumpWidget(MaterialApp(home: RegisterPage()));
        final senhaFinder = find.byWidgetPredicate(
              (widget) => widget is TextField && widget.decoration?.labelText == 'Senha',
        );

        //actio
        await tester.enterText(senhaFinder, "12345678wwW@");
        await tester.pumpAndSettle();

        expect(find.text("Senha forte."), findsOneWidget);
      });


    });
}