import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:event_app/state/query.dart';

/// Search settings dialog
class FilterOptions extends StatefulWidget {
  factory FilterOptions.fromEventStore(QueryOptions searchOptions) {
    // Parse all data to a map to be used in dialog
    // or using store data directly here
    return FilterOptions(searchOptions.toMap());
  }

  FilterOptions(this.searchOptions);
  final Map<String, dynamic> searchOptions;

  @override
  State<StatefulWidget> createState() => FilterOptionsState();
}

class FilterOptionsState extends State<FilterOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Filter Options"),
      ),
      body: _buildOptions(context),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleSaveButtonPressed,
        child: Icon(FontAwesomeIcons.solidSave),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return ListView(
      children: <Widget>[
        _buildLimitOptions(context),
        _buildSortByOptions(context),
        _buildOrderByOptions(context),
      ],
    );
  }

  /// Sort options
  Widget _buildSortByOptions(BuildContext context) {
    return _buildExpansionTile(
      context: context,
      icon: Icons.sort,
      title: "Sort",
      children: <Widget>[
        _buildRadioButton(context, "Sort By Start Date",
            "Will be sorted using start date and time", "sortOption", "start"),
        _buildRadioButton(context, "Sort By End Date",
            "Will be sorted using end date and time", "sortOption", "end"),
        _buildRadioButton(context, "Sort By Event Name",
            "Will be sorted using name of event", "sortOption", "name"),
      ],
    );
  }

  /// Order options
  Widget _buildOrderByOptions(BuildContext context) {
    return _buildExpansionTile(
      context: context,
      icon: FontAwesomeIcons.sortAlphaUp,
      title: "Order",
      children: <Widget>[
        _buildRadioButton(context, "Ascending",
            "Will be sorted in increasing order", "orderOption", "ascending"),
        _buildRadioButton(context, "Descending",
            "Will be sorted in decreasing order", "orderOption", "descending"),
      ],
    );
  }

  /// Limit options
  Widget _buildLimitOptions(BuildContext context) {
    return _buildExpansionTile(
      context: context,
      icon: Icons.plus_one,
      title: "Limit Results",
      children: <Widget>[
        _buildCheckBox(
          context,
          "Limit Results",
          "Limits result to a number. If unchecked all results will be shown.",
          "*Changing this option might affect some functinalities of the App.",
          "limitOption",
        ),
        // Slider box to get limit
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Slider(
            value: double.parse(this.widget.searchOptions["limitOptionData"]),
            max: 100.0,
            min: 10.0,
            divisions: 9,
            onChanged: this.widget.searchOptions["limitOption"] == "limit"
                ? (v) => setState(() => this
                    .widget
                    .searchOptions["limitOptionData"] = v.toInt().toString())
                : null,
            label: this.widget.searchOptions["limitOptionData"].toString(),
          ),
        ),
      ],
    );
  }

  /// Build Check box
  Widget _buildCheckBox(BuildContext context, String text, String message,
      String subMessage, String key) {
    return CheckboxListTile(
      title: Text(text),
      subtitle: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(children: <Widget>[
          Text(message),
          Text(subMessage, style: TextStyle(fontWeight: FontWeight.w700))
        ]),
      ),
      value: this.widget.searchOptions[key] == "limit",
      onChanged: (v) =>
          setState(() => this.widget.searchOptions[key] = v ? "limit" : "all"),
      activeColor: Theme.of(context).primaryColor,
    );
  }

  /// Build Check box
  Widget _buildRadioButton(BuildContext context, String text, String subtitle,
      String group, String key) {
    return RadioListTile(
      value: key,
      activeColor: Theme.of(context).primaryColor,
      groupValue: this.widget.searchOptions[group],
      onChanged: (v) => setState(() => this.widget.searchOptions[group] = key),
      title: Text(text),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildExpansionTile(
      {BuildContext context,
      IconData icon,
      String title,
      List<Widget> children}) {
    return ExpansionTile(
      title: Text(title),
      leading: Icon(
        icon,
        color: Theme.of(context).accentColor,
      ),
      children: children,
      initiallyExpanded: true,
    );
  }

  // Save and Close dialog
  // Tapping elsewhere will close without saving
  void _handleSaveButtonPressed() {
    // Parse back to store data format
    QueryOptions parsedSearchOptions =
        QueryOptions.fromMap(this.widget.searchOptions);

    // Return value
    Navigator.pop(context, parsedSearchOptions);
  }
}
