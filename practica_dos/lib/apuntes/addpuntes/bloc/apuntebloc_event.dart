part of 'apuntebloc_bloc.dart';

abstract class ApunteblocEvent extends Equatable {
  const ApunteblocEvent();
}
class EventoInicial extends ApunteblocEvent {
  @override
  List<Object> get props => [];
}
class GuardarImagen extends ApunteblocEvent {
  final File imagen;

  GuardarImagen({
    @required this.imagen,
  });

  @override
  List<Object> get props => [imagen];
}

class SubirImagen extends ApunteblocEvent {
  final String imagen;

  SubirImagen({
    @required this.imagen,
  });
  @override
  List<Object> get props => [imagen];
}
