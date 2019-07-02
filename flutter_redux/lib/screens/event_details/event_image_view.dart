import 'package:flutter/material.dart';

import 'package:event_app/state/event.dart';
import 'package:event_app/custom_widgets/zoomable_image.dart';

/// Hosts PageView and buttons.
class EventImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(this.event.eventName),
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          _buildImageBox(),
        ],
      ),
    );
  }

  /// Build Page View with Images
  Widget _buildImageBox() {
    return Center(
      child: ZoomableImage(this.event.images[this.currentIndex]),
    );
  }

  EventImageView(this.event, this.currentIndex);

  final Event event;
  final int currentIndex;
}
