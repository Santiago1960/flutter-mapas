import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mapas_app/bloc/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/bloc/bloc/mapa/mapa_bloc.dart';

import 'package:mapas_app/pages/accesso_gps_page.dart';
import 'package:mapas_app/pages/loading_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MiUbicacionBloc(),),
        BlocProvider(create: (_) => MapaBloc(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        
        home: const LoadingPage(),
        routes: {
          'mapa'        : (_) => const MapaPage(),
          'loading'     : (_) => const LoadingPage(),
          'acceso_gps'  : (_) => const AccesoGpsPage(),
        }
      ),
    );
  }
}