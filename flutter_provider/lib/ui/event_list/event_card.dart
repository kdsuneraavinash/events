import 'package:events/components/components.dart';
import 'package:events/logic/theme.dart';
import 'package:events/components/interested_pin.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theme_provider/theme_provider.dart';

class EventCard extends StatelessWidget {
  final EventView eventView;
  final VoidCallback cardOnTap;

  const EventCard({Key key, @required this.eventView, @required this.cardOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardOnTap,
      child: Card(
        key: Key(eventView.name),
        elevation: 8.0,
        child: ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _imageBannerWidget(context),
              _eventNameWidget(context),
              _timeDateWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _imageBannerWidget(BuildContext context) {
    double height = 250.0;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        Hero(
          tag: Key(eventView.name),
          child: Components.cachedNetworkImageWidget(
            imageUrl: eventView.coverImageUrl,
            width: width,
            height: height,
          ),
        ),
        Components.bottomToTopLinearGradientDecoration(
            colors: [Color(0x66000000), Color(0x66000000)],
            width: width,
            height: height),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            InterestedPin(
              eventView.iLiked,
              selectedText: "${eventView.stars}",
              unselectedText: "${eventView.stars}",
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.shareAlt, color: Colors.white),
              onPressed: () => Components.shareEvent(eventView),
            ),
          ],
        )
      ],
    );
  }

  Widget _timeDateWidget(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.timer,
            color: ThemeProvider.optionsOf<ThemeOptions>(context)
                .eventCardTimeTextColor,
          ),
          SizedBox(width: 8.0),
          Text(
            "Starts on ${eventView.startDate}",
            textAlign: TextAlign.end,
            style: TextStyle(
              color: ThemeProvider.optionsOf<ThemeOptions>(context)
                  .eventCardTimeTextColor,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _eventNameWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title:
            Text(eventView.name, style: TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(
          eventView.organizer,
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
