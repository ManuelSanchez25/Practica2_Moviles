part of 'apuntebloc_bloc.dart';

abstract class ApunteblocState extends Equatable {
  const ApunteblocState();
}

class ApunteblocInitial extends ApunteblocState {
  @override
  List<Object> get props => [];
}

class ObtenerImage extends ApunteblocState {
  final File imagen;
    ObtenerImage({@required this.imagen});

  @override
  List<Object> get props => [imagen];
}

class ErrorObtenerImagen extends ApunteblocState {
   final String errorMessage;

  ErrorObtenerImagen({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
class SubirImage extends ApunteblocState {
  final  String imagen;
    SubirImage({@required this.imagen});

  @override
  List<Object> get props => [imagen];
}

class ErrorSubirImagen extends ApunteblocState {
   final String errorMessage;

  ErrorSubirImagen({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}


