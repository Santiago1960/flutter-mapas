part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  const BtnSeguirUbicacion({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapaBloc = BlocProvider.of<MapaBloc>( context );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: ( context, state ) {
        return Container(
          margin: const EdgeInsets.only( bottom: 10 ),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              icon: Icon(
                mapaBloc.state.seguirUbicacion
                  ? Icons.directions_run
                  : Icons.accessibility_new
              ),
              color: mapaBloc.state.seguirUbicacion
                ? Colors.blueAccent
                : Colors.black87,
              onPressed: () {
                mapaBloc.add( OnSeguirUbicacion() );
              },
            ),
          ),
        );
      },
    );

  }
}