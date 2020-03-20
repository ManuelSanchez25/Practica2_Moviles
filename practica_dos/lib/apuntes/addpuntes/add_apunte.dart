import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';

import 'bloc/apuntebloc_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  File _choosenImage;

  String _url;

  bool _isLoading = false;

  TextEditingController _materiaController = TextEditingController();

  TextEditingController _descripcionController = TextEditingController();

  ApunteblocBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agregar apunte")),
      body: BlocProvider(
        create: (context) {
          bloc = ApunteblocBloc()..add(EventoInicial());

          return bloc;
        },
        child: BlocListener<ApunteblocBloc, ApunteblocState>(
          listener: (context, state) {
            if (state is ErrorObtenerImagen) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No puedes cargar la imagen, intenta nuevamente :)."),
                  ),
                );
            }

            if (state is ErrorSubirImagen) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("No se puedo subir la imagen"),
                  ),
                );
            }
          },
          child: BlocBuilder<ApunteblocBloc, ApunteblocState>(
            builder: (context, state) {
              

              if (state is ObtenerImage) {
                _choosenImage = state.imagen;
              }

              if (state is SubirImage) {
                _url = state.imagen;

                _saveData();
              }

              return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Stack(
          alignment: FractionalOffset.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _choosenImage != null
                    ? Image.file(
                        _choosenImage,
                        width: 150,
                        height: 150,
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        child: Placeholder(
                          fallbackHeight: 150,
                          fallbackWidth: 150,
                        ),
                      ),
                SizedBox(height: 48),
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {
                    bloc.add(GuardarImagen(imagen: _choosenImage));
                  },
                ),
                SizedBox(height: 48),
                TextField(
                  controller: _materiaController,
                  decoration: InputDecoration(
                    hintText: "Nombre de la materia",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _descripcionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Notas para el examen...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Guardar"),
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });

                          bloc.add(SubirImagen(imagen: _url));
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
            _isLoading ? CircularProgressIndicator() : Container(),
          ],
        ),
      ),
    );
            },
          ),
        ),
      ),
    );
  }

  void _saveData() {
    BlocProvider.of<ApuntesBloc>(context).add(
      SaveDataEvent(
        materia: _materiaController.text,
        descripcion: _descripcionController.text,
        imageUrl: _url,
      ),
    );

    _isLoading = false;

    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      Navigator.of(context).pop();
    });
  }


}
