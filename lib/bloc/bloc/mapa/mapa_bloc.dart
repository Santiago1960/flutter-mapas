import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(const MapaState()) {

    on<MapaEvent>((event, emit) {
      if( event is OnMapaListo ) {
        emit(
          state.copyWith(
            mapaListo: true
          )
        );
      }
    });
  }

  // ignore: unused_field
  late GoogleMapController _mapController;

  void initMapa( GoogleMapController controller ) {
    if( !state.mapaListo ) {
      _mapController = controller;
      _mapController.setMapStyle( jsonEncode( uberMapTheme ) );
    }
    add(OnMapaListo());
  }

  void moverCamara( LatLng destino ) {
    final cameraUpdate = CameraUpdate.newLatLng( destino );
    _mapController.animateCamera( cameraUpdate );
  }

}