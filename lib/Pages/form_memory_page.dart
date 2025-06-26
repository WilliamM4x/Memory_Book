import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_book/Models/memory_object.dart';
import 'package:memory_book/Service/memory_service.dart';
import 'package:provider/provider.dart';
import '../Provider/memory_provider.dart';

class FormMemoryPage extends StatefulWidget {
  const FormMemoryPage({super.key});

  @override
  State<FormMemoryPage> createState() => _FormMemoryPageState();
}


class _FormMemoryPageState extends State<FormMemoryPage> {

  final localController = TextEditingController();
  final descriptionControler = TextEditingController();
  //tranformar em Pick date
  final dateController = TextEditingController();
  final localizationControler= TextEditingController();

  final List<String> imagePaths = [];


  Future<void> _pickImage() async {
    final picker = ImagePicker();
    // Abre a galeria para o usuário selecionar uma imagem
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    // Se o usuário selecionou um arquivo...
    if (pickedFile != null) {
      // ...adicionamos o caminho do arquivo à nossa lista e atualizamos a UI.
      setState(() {
        imagePaths.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MemoryObject? memoryObjectProv;
    //pegar os argumentos da rota
    final arguments = ModalRoute.of(context)!.settings.arguments;

    if(arguments.runtimeType == MemoryObject){
      memoryObjectProv = arguments as MemoryObject;
      localController.text = memoryObjectProv.local;
      descriptionControler.text = memoryObjectProv.descricao;
      dateController.text = memoryObjectProv.data;
      localizationControler.text = memoryObjectProv.localizacao.toString();
      imagePaths.addAll(memoryObjectProv.imagens);
    }else{
      var localizacao = arguments as String;
      localizationControler.text = localizacao;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Memoria'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Center(
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

                      const SizedBox(height: 20),

                      // MUDANÇA: Seção para exibir as imagens e adicionar novas
                      const Text('Imagens da Memória:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),

                      // Container para exibir as miniaturas das imagens
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: imagePaths.isEmpty
                            ? const Center(child: Text('Nenhuma imagem selecionada'))
                            : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imagePaths.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              // Exibe a imagem a partir do arquivo local
                              child: Image.file(File(imagePaths[index])),
                            );
                          },
                        ),
                      ),

                      TextButton(onPressed: (){
                        _pickImage();
                      }, child: Text("Adicionar Imagem"))
                    ],
                  ),
              ),
              ElevatedButton(onPressed: (){
                String place= localController.text;
                String description = descriptionControler.text;
                String date = dateController.text;
                String localization = localizationControler.text;

                var memoryProvider = Provider.of<MemoryProvider>(context, listen: false);
                if(memoryObjectProv == null){
                  MemoryObject memoryObject = MemoryObject(

                    local: place,
                    descricao: description,
                    data: date,
                    imagens: imagePaths,
                    localizacao: [localization],
                  );

                  memoryProvider.saveMemory(memoryObject);
                }else{
                  MemoryObject memoryObject = MemoryObject(
                    id: memoryObjectProv.id,
                    local: place,
                    descricao: description,
                    data: date,
                    imagens: imagePaths,
                    localizacao: [localization],
                  );
                  memoryProvider.updateMemory(memoryObject);
                }
                Navigator.pop(context);
              },
                  child: Text("Salvar")),
            ],
          ),
        ),
      ),),
    );
  }

}