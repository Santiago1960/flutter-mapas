part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng? ubicacionCentral;

  // Polylines
  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo        = false,
    this.dibujarRecorrido = true,
    this.seguirUbicacion  = false,
    this.ubicacionCentral,
    Map<String, Polyline>? polylines
  }): polylines = polylines ?? <String, Polyline>{};

  MapaState copyWith({
    bool? mapaListo,
    bool? dibujarRecorrido,
    bool? seguirUbicacion,
    LatLng? ubicacionCentral,
    Map<String, Polyline>? polylines
  }) => MapaState(
    mapaListo       : mapaListo         ?? this.mapaListo,
    polylines       : polylines,
    dibujarRecorrido: dibujarRecorrido  ?? this.dibujarRecorrido,
    seguirUbicacion : seguirUbicacion   ?? this.seguirUbicacion,
    ubicacionCentral: ubicacionCentral  ?? ubicacionCentral
  );
}
