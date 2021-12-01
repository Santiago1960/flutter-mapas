part of 'widgets.dart';

class BtnMiRuta extends StatelessWidget {
  const BtnMiRuta({ Key? key }) : super(key: key);

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
                Icons.linear_scale,
                color: mapaBloc.state.dibujarRecorrido
                  ? Colors.pink
                  : Colors.black87
              ),
              onPressed: () {
                mapaBloc.add( OnMarcarRecorrido() );
              },
            ),
          ),
        );
      },
    );
  }
}