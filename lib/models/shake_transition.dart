import 'package:flutter/cupertino.dart';

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final double? offest;
  final Duration? duration;
  final Axis? axis;

  const ShakeTransition(
      {Key? key,
      this.offest = 140.0,
      this.axis = Axis.horizontal,
      this.duration = const Duration(seconds: 1),
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TweenAnimationBuilder(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: duration!,
      curve: Curves.elasticOut,
      child: child,
      builder: (context,double value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(
                  value * offest!,
                  0.0,
                )
              : Offset(
                  0.0,
                  value * offest!,
                ),
          child: child,
        );
      },
    );
  }
}
