import 'package:flutter/material.dart';
import 'package:practica_dos/models/apunte.dart';
import 'package:photo_view/photo_view.dart';
class Detalle extends StatefulWidget { 
   final Apunte detalleapunte ;


  Detalle({Key key, @required this.detalleapunte}) : super(key: key);


  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.detalleapunte.materia}"),
      ),
        body: Center(
          child: Column(children: <Widget>[
       Container(
           width: 400,

                height: 300 ,
           child: PhotoView(
             imageProvider: NetworkImage(widget.detalleapunte.imageUrl)
       ,) 
       ,
       ),
            
            Text("${widget.detalleapunte.descripcion}",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),)
          ],
          
          ),
        ),
        
       );

  }

}