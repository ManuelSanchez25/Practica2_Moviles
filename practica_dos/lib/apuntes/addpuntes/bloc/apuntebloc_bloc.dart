import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart' as Path;


part 'apuntebloc_event.dart';
part 'apuntebloc_state.dart';

class ApunteblocBloc extends Bloc<ApunteblocEvent, ApunteblocState> {
  final Firestore _firestoreInstance = Firestore.instance;
  File _choosenImage;
  String _url;
  bool _isLoading = false;


  @override
  ApunteblocState get initialState => ApunteblocInitial();

  @override
  Stream<ApunteblocState> mapEventToState(
    ApunteblocEvent event,
  ) async* {
     if (event is GuardarImagen) {
      bool dataRetrieved = await _chooseImage();
      if (dataRetrieved){
        yield ObtenerImage(imagen:_choosenImage );
        }
      else
        yield ErrorObtenerImagen(
          errorMessage: "No se ha podido conseguir la imagen.",
        );
    }
    else if (event is SubirImagen) {
      bool save = await _uploadFile();
      if (save) {
   
        yield SubirImage(imagen: _url);
      } else
        yield ErrorSubirImagen(
          errorMessage: "Ha ocurrido un error. Intente guardar la imagen mas tarde.",
        );
    }else if (event is EventoInicial)
    yield ApunteblocInitial();

  }
  
  Future<bool> _chooseImage() async {
    try{
 await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 720,
    ).then(( image) {
        _choosenImage = image ;
    });
    return true;
    }catch(e){
return false;
    }
    
  }
   Future _uploadFile() async {
 try{
      String filePath = _choosenImage.path;
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child("apuntes/${Path.basename(filePath)}");
    StorageUploadTask uploadTask = reference.putFile(_choosenImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      print("Link>>>>> $imageUrl");
    });

   await  reference.getDownloadURL().then((fileURL) {
      print("$fileURL");
        _url = fileURL;
        
    });
     return true;
    }catch(e){
return false;
    }
    
  }
 }
 
 
