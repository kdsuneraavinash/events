import 'package:events/components/components.dart';
import 'package:events/logic/event/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class EventDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Linkify(
            onOpen: (url) => Components.launchURL(url.url),
            text: Provider.of<EventView>(context).description,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, letterSpacing: 0.2),
          ),
        ),
        SizedBox(height: 50)
      ],
    );
  }
}
