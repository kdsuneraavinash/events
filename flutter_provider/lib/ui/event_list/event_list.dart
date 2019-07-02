import 'package:events/logic/event/event_controller.dart';
import 'package:events/logic/theme.dart';
import 'package:events/ui/event_list/event_card.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

typedef EventListCallback(BuildContext context, EventView eventView);

class EventList extends StatelessWidget {
  /// Will provide requirements to get the reference of [EventView] clicked.
  final EventListCallback onTap;

  const EventList({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LiquidPullToRefresh(
      showChildOpacityTransition: false,
      backgroundColor:
          ThemeProvider.optionsOf<ThemeOptions>(context).pullToRefreshBallColor,
      color: ThemeProvider.optionsOf<ThemeOptions>(context)
          .pullToRefreshBackgroundColor,
      onRefresh: () async => await Future.delayed(Duration(seconds: 3)),
      child: ListView.builder(
        itemBuilder: (_, index) {
          EventView eventView =
              Provider.of<EventViewController>(context).ofIndex(index);
          if (eventView == null) {
            return null;
          }
          return EventCard(
            eventView: eventView,
            cardOnTap: () => onTap(context, eventView),
          );
        },
      ),
    );
  }
}
