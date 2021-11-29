import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({ Key? key }) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: ( context, state ) {
            if( !state.existeUbicacion ) {
              return const Text( 'Obteniendo Ubicación...' );
            }
            final mapaBloc = BlocProvider.of<MapaBloc>(context);
            final cameraPosition = CameraPosition(
              target: state.ubicacion!,
              zoom: 15,tilt: 10
            );
            return GoogleMap(
              initialCameraPosition: cameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: mapaBloc.initMapa,
            );
          },
        )
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnUbicacion(),
        ],
      ),
    );
  }
}