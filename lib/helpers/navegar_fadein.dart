part of 'helpers.dart';

Route navegarMapaFadeIn( BuildContext context, Widget page ) {

  return PageRouteBuilder(
    pageBuilder: ( BuildContext _, __, ___ ) => page,
    transitionDuration: const Duration( seconds: 2 ),
    transitionsBuilder: ( context, animation, _, child ) {

      return FadeTransition(
        child: child,
        opacity: Tween<double>( begin: 0, end: 1 ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut
          )
        )
      );
    }
  );
}