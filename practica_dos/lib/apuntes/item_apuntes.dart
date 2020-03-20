import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';
import 'package:practica_dos/models/apunte.dart';

import 'detalleContacto.dart';

class ItemApuntes extends StatefulWidget {
  final String imageUrl;
  final String materia;
  final String descripcion;
  final int index;
  ItemApuntes({
    Key key,
    @required this.imageUrl,
    @required this.index,
    @required this.materia,
    @required this.descripcion,
  }) : super(key: key);

  @override
  _ItemApuntesState createState() => _ItemApuntesState();
}

class _ItemApuntesState extends State<ItemApuntes> {

    void _abrirdetalle(Apunte a) {

    Navigator.of(context).push(

        MaterialPageRoute(builder: (context) => Detalle(detalleapunte: a))

    );

  }
   _showAlertDialog(BuildContext context) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {
       _deleteItem();
        Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Eliminar card"),
    content: Text("¿Seguro que desea eliminar ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
  @override
  Widget build(BuildContext context) {
     return GestureDetector(

      onTap: () {

        Apunte descripcion = Apunte(materia: widget.materia, descripcion: widget.descripcion, imageUrl: widget.imageUrl);

        print("tap: $descripcion");

        _abrirdetalle(descripcion);

      },
    child: Card(
      margin: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                 _showAlertDialog(context);
                },
              )
            ],
          ),
          Image.network(
            widget.imageUrl ?? "https://via.placeholder.com/150",
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text(
              "${widget.materia}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Text("${widget.descripcion}"),
          ),
          SizedBox(height: 12),
        ],
      ),
    ),
    );
  }


void _deleteItem() {

  BlocProvider.of<ApuntesBloc>(context).add(

    RemoveDataEvent(index: widget.index),

  );

}


 

}
