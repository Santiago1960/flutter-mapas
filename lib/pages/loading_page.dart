import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/pages/accesso_gps_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({ Key? key }) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver( this );
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver( this );
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if( state == AppLifecycleState.resumed ) {
      if( await Geolocator.isLocationServiceEnabled() ) {
        Navigator.pushReplacement( context, navegarMapaFadeIn( context, const MapaPage() ) );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {

          if( snapshot.hasData ) {
            return Center( child: Text( snapshot.data ), );
          } else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      )
    );
  }

  Future checkGpsYLocation( BuildContext context ) async {

    // Permiso GPS
    final permisoGPS = await Permission.location.isGranted;
    // GPS está activo?
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if( permisoGPS && gpsActivo ) {
      Navigator.pushReplacement( context, navegarMapaFadeIn( context, const MapaPage() ) );
      return 'OK';
    } else if( !permisoGPS ) {
      Navigator.pushReplacement( context, navegarMapaFadeIn( context, const AccesoGpsPage() ) );
      return 'Es necesario el permiso de GPS';
    } else {

      return 'Activa el GPS';
    }
  }
}