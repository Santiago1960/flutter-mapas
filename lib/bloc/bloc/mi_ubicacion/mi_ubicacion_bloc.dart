import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mi_ubicacion_event.dart';
part 'mi_ubicacion_state.dart';

class MiUbicacionBloc extends Bloc<MiUbicacionEvent, MiUbicacionState> {
  MiUbicacionBloc() : super(const MiUbicacionState()) {


    on<MiUbicacionEvent>((event, emit) {
      // implement event handler
      if( event is OnUbicacionCambio ) {
        emit(
          state.copyWith(
            siguiendo: siguiendo,
            existeUbicacion: true,
            ubicacion: event.ubicacion
          )
        );
      }
    });

/*     on<OnUbicacionCambio>( ( event, emit ) {
      if( event is OnUbicacionCambio ) {
        emit(
          state.copyWith(
            existeUbicacion: true,
            ubicacion: event.ubicacion
          )
        );
      }
    }); */

    /* on<MiUbicacionState> mapEventToState( MiUbicacionEvent event ) async* {
      print( 'Entro OnUbicacionCambio con $event' );
      if( event is OnUbicacionCambio ) {
        yield state.copyWith(
          existeUbicacion: true,
          ubicacion: event.ubicacion
        );
      }
    } */
  }

  StreamSubscription<Position>? _positionSubscription;

  get siguiendo => true;

  void iniciarSeguimiento() {
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
      distanceFilter: 20
    ).listen(( Position position ) {
      final nuevaUbicacion = LatLng( position.latitude, position.longitude );
      add( OnUbicacionCambio( nuevaUbicacion ) );
    });
  }

  void cancelarSeguimiento() {
    _positionSubscription?.cancel();
  }

}

