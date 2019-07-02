import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:event_app/state/event.dart';
import 'package:event_app/screens/event_details/event_info.dart';
import 'package:event_app/screens/event_details/event_links.dart';
import 'package:event_app/screens/event_details/event_images.dart';

/// Event Details Page which hosts a PageView to show all info
class EventDetails extends StatefulWidget {
  @override
  EventDetailsState createState() {
    return new EventDetailsState();
  }

  final PageController pageController = new PageController(initialPage: 0);
  final Event event;

  EventDetails(this.event);
}

/// State of EventDetails
/// Will contain a PageView and a BottomNavigationBar to navigate
class EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event Info"),
      ),
      body: _buildPagedWindow(
        widget.event,
        PageView(
          controller: widget.pageController,
          onPageChanged: _handlePageChanged,
          children: <Widget>[
            EventInfo(widget.event),
            ImageGrid(widget.event),
            EventLinks(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: _handleBottomNavigationBarTap,
        currentIndex: this.currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.database),
            title: Text("Event Info"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.images),
            title: Text("Images"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.link),
            title: Text("Contact"),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  /// Window with start date and end date pinned.
  Widget _buildPagedWindow(Event event, Widget child) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _buildInlineListTile(
          "Start Date",
          event.startTimeString,
          FontAwesomeIcons.hourglassStart,
          context,
        ),
        _buildInlineListTile(
          "End Date",
          event.endTimeString,
          FontAwesomeIcons.hourglassEnd,
          context,
        ),
        Expanded(
          child: child,
        )
      ],
    );
  }

  Widget _buildInlineListTile(
      String title, String text, IconData icon, BuildContext context) {
    ThemeData currentTheme = Theme.of(context);
    return Container(
      color: currentTheme.primaryColor,
      child: ListTile(
        leading: Icon(
          icon,
          color: currentTheme.scaffoldBackgroundColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: currentTheme.scaffoldBackgroundColor,
          ),
        ),
        trailing: Text(
          text,
          style: TextStyle(
            color: currentTheme.scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }

  /// Animate PageView when BottomNavigationBar is tapped.
  /// If far away, jump to it.
  void _handleBottomNavigationBarTap(int index) {
    if ((currentIndex - index).abs() > 1) {
      // Jump to page if page is far away
      widget.pageController.jumpToPage(
        index,
      );
    } else {
      widget.pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
    setState(() {
      currentIndex = index;
    });
  }

  /// Change index of BottomNavigationBar if PageView is turned
  void _handlePageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  int currentIndex = 0;
}
