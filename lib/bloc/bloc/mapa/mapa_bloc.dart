import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/themes/uber_map_theme.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(MapaState()) {

    on<MapaEvent>((event, emit) {
      if( event is OnMapaListo ) {
        emit(
          state.copyWith(
            mapaListo: true
          )
        );
      }
      if( event is OnNuevaUbicacion ) {
        if ( state.seguirUbicacion ) {
          moverCamara( event.ubicacion );
        }
        List<LatLng> points = [ ..._miRuta.points, event.ubicacion ];
        _miRuta = _miRuta.copyWith( pointsParam: points );

        final currentPolylines = state.polylines;
        currentPolylines[ 'mi_ruta' ] = _miRuta;
        emit(
          state.copyWith(
            polylines: currentPolylines
          )
        );
      }
      if( event is OnMarcarRecorrido ) {
        if( !state.dibujarRecorrido ) {
          _miRuta = _miRuta.copyWith( colorParam: Colors.pink );
        } else {
          _miRuta = _miRuta.copyWith( colorParam: Colors.transparent );
        }
        final currentPolylines = state.polylines;
        currentPolylines[ 'mi_ruta' ] = _miRuta;
        emit(
          state.copyWith(
            dibujarRecorrido: !state.dibujarRecorrido,
            polylines: currentPolylines
          )
        );
      }
      if( event is OnSeguirUbicacion ) {
        emit(
          state.copyWith(
            seguirUbicacion: !state.seguirUbicacion
          )
        );
      }
      if( event is OnMovioMapa ) {
        print( event.centroMapa );
        emit(
          state.copyWith(
            ubicacionCentral: event.centroMapa
          )
        );
      }
    });
  }

  // CONTROLADOR DEL MAPA
  // ignore: unused_field
  late GoogleMapController _mapController;

  //POLYLINES
  Polyline _miRuta = const Polyline(
    polylineId: PolylineId( 'mi_ruta' ),
    color: Colors.pink,
    width: 4
  );

  void initMapa( GoogleMapController controller ) {
    if( !state.mapaListo ) {
      _mapController = controller;
      _mapController.setMapStyle( jsonEncode( uberMapTheme ), );
    }
    add(OnMapaListo());
  }

  void moverCamara( LatLng destino ) {
    final cameraUpdate = CameraUpdate.newLatLng( destino );
    _mapController.animateCamera( cameraUpdate );
  }

}
