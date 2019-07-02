import 'package:cached_network_image/cached_network_image.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Components {
  static void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('ERROR: Could not launch $url');
    }
  }

  static void shareEvent(EventView eventView) {
    Share.share("Check out this awesome event:\n"
        "${eventView.name}\n"
        "on ${eventView.startDate}\n"
        "in ${eventView.venue}");
  }

  static bool isMobileDevice(BoxConstraints constraints) {
    return constraints.maxWidth < 600;
  }

  static bool isMobileDeviceFromContext(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static Widget cachedNetworkImageWidget({
    String imageUrl,
    double height,
    double width,
  }) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: height,
      width: width,
      placeholder: (_, __) => Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
      errorWidget: (_, __, ___) => Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: Icon(
              FontAwesomeIcons.image,
              size: 36.0,
            ),
          ),
    );
  }

  static bottomToTopLinearGradientDecoration(
      {List<Color> colors, double width, double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}

class NoAnimationScrollBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
