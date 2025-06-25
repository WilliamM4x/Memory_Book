import 'package:flutter/material.dart';
import 'package:memory_book/Models/memory_object.dart';
import 'package:provider/provider.dart';
import '../Provider/memory_provider.dart';

class FormMemoryPage extends StatelessWidget {

  FormMemoryPage({super.key});


  final localController = TextEditingController();
  final descriptionControler = TextEditingController();
  //tranformar em Pick date
  final dateController = TextEditingController();
  final localizationControler= TextEditingController();
  //futuramente isso será o link base64
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context)!.settings.arguments;

    if(arguments.runtimeType == MemoryObject){
      var memoryObject = arguments as MemoryObject;
      localController.text = memoryObject.local;
      descriptionControler.text = memoryObject.descricao;
      dateController.text = memoryObject.data;
      localizationControler.text = memoryObject.localizacao.toString();
      imageController.text = memoryObject.imagens.toString();
    }else{
      var localizacao = arguments as String;
      localizationControler.text = localizacao;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Memoria'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      TextField(
                        controller: localController,
                        decoration: InputDecoration(
                          hintText: 'Local',
                        ),
                      ),
                      TextField(
                        controller: descriptionControler,
                        decoration: InputDecoration(
                          hintText: 'Descrição',
                        ),
                      ),
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: 'Data',
                        ),
                      ),
                      TextField(
                        readOnly: true,
                        controller: localizationControler,
                          //TextEditingController(text: arguments.toString()),
                        decoration: InputDecoration(
                          hintText: 'Localização',
                        ),
                      ),
                      TextField(
                        controller: imageController,
                        decoration: InputDecoration(
                          hintText: 'Imagem',
                        ),
                      ),
                    ],
                  ),
              ),
              ElevatedButton(onPressed: (){
                String place= localController.text;
                String description = descriptionControler.text;
                String date = dateController.text;
                String localization = localizationControler.text;
                String image = imageController.text;

                MemoryObject memoryObject = MemoryObject(
                  local: place,
                  descricao: description,
                  data: date,
                  imagens: [image],
                  localizacao: [localization],
                );
                var memoryProvider = Provider.of<MemoryProvider>(context, listen: false);

                memoryProvider.saveMemory(memoryObject);
                Navigator.pop(context);

              },
                  child: Text("Salvar")),
            ],
          ),
        ),
      ),
    );
  }

}