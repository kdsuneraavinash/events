import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

import 'package:event_app/redux_store/middleware.dart';
import 'package:event_app/redux_store/reducers.dart';
import 'package:event_app/redux_store/store.dart';

/// Main store holder (REDUX)
/// Create Persistor.
///
/// https://pub.dartlang.org/packages/redux_persist_flutter#-readme-tab-
Persistor<EventState> persistor = Persistor<EventState>(
  // TODO: Save to documents folder if it is stable
  storage: FlutterStorage("my-app"), // Or use other engines
  decoder: EventState.fromJson,
);

final baseStore = Store<EventState>(
  reducers,
  initialState: EventState.empty(),
  middleware: [
    EpicMiddleware<EventState>(
        combineEpics([readAllDocuments, listenToChanges])),
    persistor.createMiddleware()
  ],
);
