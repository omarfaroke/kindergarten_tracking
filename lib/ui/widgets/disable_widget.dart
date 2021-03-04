import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  const DisableWidget({
    Key key,
    this.child,
    this.condition = true,
    this.withOpacity = true,
  }) : super(key: key);
  final Widget child;
  final bool condition;
  final bool withOpacity;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: condition,
      child: withOpacity
          ? Opacity(
              opacity: !condition ? 1 : 0.6,
              child: child,
            )
          : child,
    );
  }
}
