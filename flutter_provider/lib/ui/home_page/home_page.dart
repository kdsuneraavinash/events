import 'package:events/components/components.dart';
import 'package:events/logic/event/event_controller.dart';
import 'package:events/ui/event_list/event_list.dart';
import 'package:events/ui/event_page/event_page.dart';
import 'package:events/ui/home_page/drawer.dart';
import 'package:events/ui/home_page/end_drawer.dart';
import 'package:events/ui/home_page/bottom_app_bar.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Events."),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (_) => ThemeConsumer(
                                child: ThemeDialog(
                              selectedOverlayColor:
                                  Colors.white.withAlpha(0x22),
                            )),
                      ),
                  icon: Icon(FontAwesomeIcons.palette),
                ),
          )
        ],
      ),
      body: ChangeNotifierProvider(
        builder: (_) => EventViewController.fromLocalFile(),
        child: LayoutBuilder(
          builder: (_, constraints) => Components.isMobileDevice(constraints)
              ? MobileHomePage()
              : TabletHomePage(),
        ),
      ),
      drawer: AppDrawer(),
      endDrawer: CategoryDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.syncAlt),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: HomePageBottomAppBar(),
      extendBody: true,
    );
  }
}

/// Views A Layout in Mobile.
///
/// Views only the [EventList].
/// Once an item in [EventList] is tapped, a [MaterialPageRoute] will direct to [EventPage].
/// [EventPage] will have a scaffold.
/// Here [_viewEventInNewPage] will control what happens when card is tapped.
class MobileHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventList(onTap: _viewEventInNewPage);
  }

  /// Goto Event Page when tapped on a card
  void _viewEventInNewPage(BuildContext context, EventView eventView) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Provider<EventView>.value(
              value: eventView,
              child: ThemeConsumer(child: MobileEventPage()),
            ),
      ),
    );
  }
}

/// Views A Layout in Tablets.
///
/// Views [EventList] and [EventPage] side by side.
/// No scaffold for [EventPage].
/// Once an item in [EventList] is tapped, this will load the specific event to [EventPage].
/// [_waitAndLoadEventOnSideBar] will control this functionality.
class TabletHomePage extends StatefulWidget {
  @override
  _TabletHomePageState createState() => _TabletHomePageState();
}

class _TabletHomePageState extends State<TabletHomePage> {
  /// Current selected Event Card Data. null if nothing selected
  EventView currentSelectedEvent;

  /// Variable used to show a loading animation before loading the [EventView]
  bool isEventDetailsPageLoading = false;

  @override
  Widget build(BuildContext context) {
    double halfPageWidth = MediaQuery.of(context).size.width / 2;

    return Row(
      children: <Widget>[
        SizedBox(
          width: halfPageWidth,
          child: EventList(onTap: _waitAndLoadEventOnSideBar),
        ),
        VerticalDivider(color: Theme.of(context).primaryColor, width: 0.0),
        SizedBox(
          width: halfPageWidth,
          child: isEventDetailsPageLoading
              ? Center(child: CircularProgressIndicator())
              : currentSelectedEvent == null
                  ? Center(child: Icon(FontAwesomeIcons.box, size: 32))
                  : Provider<EventView>.value(
                      value: currentSelectedEvent,
                      child: TabletEventPage(),
                    ),
        ),
      ],
    );
  }

  void _waitAndLoadEventOnSideBar(
      BuildContext context, EventView eventView) async {
    setState(() {
      isEventDetailsPageLoading = true; // First mark as loading
    });
    await Future.delayed(Duration(seconds: 1)); // Wait a second
    setState(() {
      isEventDetailsPageLoading = false; // Mark as finished loading
      currentSelectedEvent = eventView;
    });
  }
}
