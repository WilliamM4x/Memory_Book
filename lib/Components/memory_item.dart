import 'package:flutter/material.dart';

import 'package:memory_book/Models/memory_object.dart';
import 'package:provider/provider.dart';

import '../Provider/memory_provider.dart';
import 'argument_origin.dart';
import '../routes.dart';

class MemoryItem extends StatelessWidget{

  final MemoryObject memoryObject;

  const MemoryItem(this.memoryObject, {super.key});

  @override
  Widget build(BuildContext context) {
    var providerMemory = Provider.of<MemoryProvider>(context, listen: true);
    return  ListTile(
      onLongPress: (){
        Future<void> _showMyDialog() async {
          return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Deletar Memória'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Está certo que deseja deletar?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Confirmar'),
                    onPressed: () {
                      providerMemory.deleteMemory(memoryObject);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
        _showMyDialog();
      },
      onTap: (){
        //tem que ir para toda memoria onde terá imagem dela e afins
        Navigator.pushNamed(context, Routes.ONLY_MEMORY, arguments: memoryObject);
      } ,
      title: Text(memoryObject.local),
      subtitle: Text(memoryObject.descricao),

      trailing: IconButton(onPressed: (){
        Navigator.pushNamed(context, Routes.FORM_MEMORY, arguments: memoryObject);
      }, icon: Icon(Icons.edit)),
    );
  }

}