import 'dart:async';
import 'dart:io' as IO;

import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import 'package:event_app/redux_store/actions.dart' as Actions;
import 'package:event_app/redux_store/store.dart';
import 'package:event_app/state/query.dart';
import 'package:event_app/screens/credits.dart';
import 'package:event_app/screens/event_flagged.dart';
import 'package:event_app/screens/event_list/event_list_body.dart';
import 'package:event_app/screens/event_notifications.dart';
import 'package:event_app/screens/event_list/filter_options.dart';
import 'package:event_app/custom_widgets/transition_maker.dart';

/// Main Page that displays a list of available Events.
/// Will connect [StoreBuilder].
/// On init will start to listen to updates
/// and on dispose will stop listening
class EventListWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder(
      builder: _buildEventListWindow,
      onInit: (eventStore) {
        // Commenting this out
        eventStore.dispatch(Actions.FirestoreRefreshAll());
        eventStore.dispatch(Actions.FirestoreListenToUpdates());
      },
      onDispose: (eventStore) =>
          eventStore.dispatch(Actions.FirestoreEndConnection()),
    );
  }

  /// Builds scaffold with searchbar, drawer and other action buttons
  Widget _buildEventListWindow(
      BuildContext context, Store<EventState> eventStore) {
    // SearchBoxedScaffold is a widget that will
    // enclose a scaffold with a search button inside.
    // SearchBoxedScaffold is statefull
    return SearchBoxedScaffold(
      appBarTitle: Text("Mora Events"),
      appBarActions: <Widget>[
        // Filter Settings Button
        IconButton(
          icon: Icon(Icons.filter_list),
          onPressed: () => _handleFilterAction(context, eventStore),
        ),
      ],
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            // Drawer heading
            DrawerHeader(
              child: Text(
                "Mora Events",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            ),
            // Notifications button
            ListTile(
              leading: eventStore.state.notifications.any((v) => !v.read)
                  ? Icon(
                      Icons.notifications_active,
                      color: Theme.of(context).accentColor,
                    )
                  : Icon(Icons.notifications_none),
              title: Text("Notifications"),
              subtitle: Text("View latest event notifications"),
              onTap: () => _handleNotificationsAction(context),
            ),
            // Flagged events button
            ListTile(
              leading: Icon(FontAwesomeIcons.mapPin),
              title: Text("Pinned Events"),
              subtitle: Text("Show events that you pinned"),
              onTap: () => _handleFlaggedAction(context),
            ),
            // Credits button
            ListTile(
              leading: Icon(FontAwesomeIcons.questionCircle),
              title: Text("Credits"),
              subtitle: Text("About our team"),
              onTap: () => _handleCreditsAction(context),
            ),
          ],
        ),
      ),
      body: EventListBody(eventStore),
      // Passing store inside to searchString dispatch
      eventStore: eventStore,
    );
  }

  /// Alert box to inform that there isn't an internet connection
  /// Sometimes it may take some time in order for alert box to show up
  Widget _buildNoInternetDialog(BuildContext context) {
    return AlertDialog(
      content: Text(
        "Please make sure that you are connected to internet. "
            "Filter feature is available only in online mode",
        style: Theme.of(context).textTheme.body1,
      ),
      contentPadding: EdgeInsets.all(16.0),
      title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(
            Icons.warning,
            color: Theme.of(context).accentColor,
          ),
        ),
        Text("Filter"),
      ]),
      actions: <Widget>[
        FlatButton(
          child: Text("Close"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }

  /// Show credits window
  void _handleCreditsAction(BuildContext context) {
    Navigator.pop(context);
    TransitionMaker
        .slideTransition(
          destinationPageCall: () => Credits(),
        )
        .start(context);
  }

  /// Show filter settings buttons and set the options.
  /// This will first make sure user is connected.
  /// If not will show a alertbox.
  void _handleFilterAction(
      BuildContext context, Store<EventState> eventStore) async {
    // Make sure person is connected
    bool isConnected = await _makeSureIsConnected();
    if (!isConnected) {
      // Not connected to internet. Abort.
      await showDialog(context: context, builder: _buildNoInternetDialog);
      return;
    }
    // Get a instance of query options
    QueryOptions searchOptions = eventStore.state.searchOptions;
    // Shows the window and lets user choose options
    // Will wait until user closes the options box
    searchOptions = await TransitionMaker
        .slideTransition(
          destinationPageCall: () =>
              FilterOptions.fromEventStore(searchOptions),
        )
        .startAndWait(context);
    // searchOptions will be null if user pressed back button instead of Save
    if (searchOptions != null) {
      // User has pressed save.
      // So save settings and refresh.
      eventStore.dispatch(Actions.SearchOptionsSet(searchOptions));
      eventStore.dispatch(Actions.FirestoreRefreshAll());
    }
  }

  /// Show flagged events page
  void _handleFlaggedAction(BuildContext context) {
    Navigator.pop(context);
    TransitionMaker
        .slideTransition(
          destinationPageCall: () => FlaggedEventManager(),
        )
        .start(context);
  }

  /// Show notifications page
  void _handleNotificationsAction(BuildContext context) {
    Navigator.pop(context);
    TransitionMaker
        .slideTransition(
          destinationPageCall: () => EventNotificationsManager(),
        )
        .start(context);
  }
}

/// Makes sure user is connected to internet.
/// Will never fire false negatives.
Future<bool> _makeSureIsConnected() async {
  try {
    // Try to connect
    final result = await IO.InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      // Got a result
      // *Possibly* connected
      // Not 100% accurate
      return true;
    }
  } catch (_) {
    // Nothing
    // Silents the error
  } finally {
    // Connecting failed
    // No internet
    return false;
  }
}

/// Custom widget to enclose the whole widget tree with a search box
/// Will show a search button at the end of app bar
/// when pressed, will show a text box which will update [store.state.searchString]
/// in real time.
class SearchBoxedScaffold extends StatefulWidget {
  @override
  _SearchBoxedScaffoldState createState() => _SearchBoxedScaffoldState();

  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final Widget drawer;
  final Widget body;
  final Store<EventState> eventStore;
  SearchBoxedScaffold(
      {this.appBarTitle,
      this.appBarActions,
      this.drawer,
      this.body,
      this.eventStore});
}

// State
class _SearchBoxedScaffoldState extends State<SearchBoxedScaffold> {
  SearchBar searchBar;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.build(context),
      drawer: widget.drawer,
      body: widget.body,
    );
  }

  void _textChanged() {
    widget.eventStore.dispatch(Actions.SearchStringSet(controller.text));
  }

  /// On init
  /// - Adds a listener to check text change
  /// - create search bar
  _SearchBoxedScaffoldState() {
    controller.addListener(_textChanged);
    searchBar = SearchBar(
      inBar: true,
      setState: setState,
      buildDefaultAppBar: (_) => _buildDefaultAppBar(),
      clearOnSubmit: false,
      closeOnSubmit: false,
      controller: controller,
    );
  }

  /// Default app bar.
  /// will be also fired when user pressed Back or Close.
  AppBar _buildDefaultAppBar() {
    // When showing default bar, search string = ""
    controller.text = "";
    IconButton searchButton = IconButton(
      icon: Icon(Icons.search),
      onPressed: searchBar.getSearchAction(context).onPressed,
    );
    return AppBar(
      title: widget.appBarTitle,
      actions: List.from(widget.appBarActions)..add(searchButton),
    );
  }

  /// Remove listners
  @override
  void dispose() {
    controller.removeListener(_textChanged);
    super.dispose();
  }
}
