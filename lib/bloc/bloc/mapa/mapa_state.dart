part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;

  const MapaState({
    this.mapaListo = false
  });

  MapaState copyWith({
    bool? mapaListo
  }) => MapaState(
    mapaListo: mapaListo!
  );
}