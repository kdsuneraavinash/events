import 'dart:async';

import 'package:flutter/material.dart';

/// Builds a basic animated route transition
class TransitionMaker {
  final destinationPageCall;
  dynamic transitionBuilder;

  /// Use fade animation
  TransitionMaker.fadeTransition({
    this.destinationPageCall,
    double beginOpacity = 0.0,
    double endOpacity = 1.0,
  }) {
    this.transitionBuilder =
        (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(
        opacity: Tween<double>(begin: beginOpacity, end: endOpacity)
            .animate(animation),
        child: child,
      );
    };
  }

  /// Use slide animation
  TransitionMaker.slideTransition({
    this.destinationPageCall,
    Offset beginOffset,
    Offset endOffset,
  }) {
    beginOffset ??= Offset(1.0, 0.0);
    endOffset ??= Offset(0.0, 0.0);
    this.transitionBuilder =
        (_, Animation<double> animation, __, Widget child) {
      return SlideTransition(
        position: Tween<Offset>(begin: beginOffset, end: endOffset)
            .animate(animation),
        child: child,
      );
    };
  }

  /// Start animation
  void start(BuildContext context) {
    Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) {
              return this.destinationPageCall();
            },
            transitionsBuilder: this.transitionBuilder,
          ),
        );
  }

  /// Start animation as async.
  /// *Suitable for dialog boxes*
  Future startAndWait(BuildContext context) async {
    var result = await Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) {
              return this.destinationPageCall();
            },
            transitionsBuilder: this.transitionBuilder,
          ),
        );
    return result;
  }
}
