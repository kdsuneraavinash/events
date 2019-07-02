import 'package:flutter/material.dart';

import 'package:event_app/state/event.dart';
import 'package:event_app/screens/event_details/event_image_view.dart';
import 'package:event_app/custom_widgets/network_image.dart';
import 'package:event_app/custom_widgets/transition_maker.dart';

/// Creates an Image Grid
class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> images = [];
    for (int index = 0; index < event.images.length; index++) {
      String url = event.images[index];
      images.add(InkWell(
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: DefParameterNetworkImage(
            imageUrl: url,
            isCover: true,
          ),
        ),
        onTap: () => _handleImageTap(context, index),
      ));
    }

    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        children: images,
      ),
    );
  }

  /// Show image when tapped
  void _handleImageTap(BuildContext context, int index) {
    TransitionMaker
        .fadeTransition(
          destinationPageCall: () => EventImageView(this.event, index),
        )
        .start(context);
  }

  final Event event;
  ImageGrid(this.event);
}
