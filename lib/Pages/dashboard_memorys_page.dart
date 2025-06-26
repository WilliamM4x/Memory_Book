import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../Components/memory_list.dart';
import '../routes.dart';

class DashboardMemorysPage extends StatefulWidget{


  @override
  State<DashboardMemorysPage> createState(){
    return DashboardMemorysPageState();
  }
}

class DashboardMemorysPageState extends State<DashboardMemorysPage>{

  @override
  Widget build(BuildContext context) {
    var localizacao;

    //abstrair para um provider ou classe qualquer
    Future<Position> _geoLocation() async {
      bool isEnable = await Geolocator.isLocationServiceEnabled();
      if (!isEnable) {
        return Future.error('Serviço de localização desativado');
      }else {
        LocationPermission permisson = await Geolocator.checkPermission();
        if(permisson == LocationPermission.denied){

          Geolocator.requestPermission().then((value) async {
            if(value == LocationPermission.denied &&
                value == LocationPermission.deniedForever){
              return Future.error('Permissão negada');
            }
          });
        }
        return await Geolocator.getCurrentPosition();
      }
    }

    Future<Placemark> _geoAdress() async {
      bool isEnable = await Geolocator.isLocationServiceEnabled();
      if (!isEnable) {
        return Future.error('Serviço de localização desativado');
      }else {
        LocationPermission permisson = await Geolocator.checkPermission();
        if(permisson == LocationPermission.denied){

          Geolocator.requestPermission().then((value) async {
            if(value == LocationPermission.denied &&
                value == LocationPermission.deniedForever){
              return Future.error('Permissão negada');
            }
          });
        }
        Position position = await Geolocator.getCurrentPosition();
        var latitude=position.latitude;
        var longitude= position.longitude;
        List<Placemark> placeMark = await placemarkFromCoordinates(latitude,longitude);
        return placeMark.first;
      }
    }


    return Scaffold(
       appBar: AppBar(
        title: Text('Memorias'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

       body:SafeArea(
         child:FutureBuilder(
           future: _geoLocation(),
           builder: (context, snapshot) {
             if(snapshot.hasData){
               localizacao= "${snapshot.data?.latitude.toString()}:${snapshot.data?.longitude.toString()}";
                return Center(
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: _geoAdress(),
                          builder: (contex, snapshop2){
                            if(snapshop2.hasData){
                            return Center(
                            child:Text('Localização: ${snapshop2.data?.subAdministrativeArea},${snapshop2.data?.country}'),
                            );
                            }else{
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            };
                          }),

                     Expanded(
                         child: MemoryList()
                     ),
                    ],
                  ),
                );

             }else{
               return Center(
                 child: CircularProgressIndicator(),
               );
             }
           }),),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.FORM_MEMORY, arguments: localizacao);
        },
        child: Icon(Icons.add),
      ),
    );


  }
}


