import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:event_app/theme.dart' as Theme;
import 'package:event_app/screens/event_list.dart';
import 'package:event_app/redux_store/store_declaration.dart';

/// Run main App
void main() {
  return runApp(MoraEventsApp());
}

/// App Main Entry Point
/// Sets up theme
/// Will connect Store Provider and Persistor
/// to the [MaterialApp].
class MoraEventsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PersistorGate(
      persistor: persistor,
      builder: (context) => StoreProvider(
            store: baseStore,
            child: StoreProvider(
              child: MaterialApp(
                title: "MoraEvents",
                theme: Theme.buildTheme(context),
                home: EventListWindow(),
              ),
              store: baseStore,
            ),
          ),
    );
  }

  /// Initializer which loads persistant data
  /// to the state.
  MoraEventsApp() {
    persistor.load(baseStore);
  }
}
