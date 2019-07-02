enum QueryOptionsSort { NAME, START, END }
enum QueryOptionsOrder { ASCENDING, DESCENDING }
enum QueryOptionsLimit { ALL, LIMIT }

class QueryOptions {
  final QueryOptionsSort sortOption;
  final QueryOptionsOrder orderOption;
  final QueryOptionsLimit limitOption;
  final int limitOptionData;

  QueryOptions(this.sortOption, this.orderOption, this.limitOption,
      this.limitOptionData);

  factory QueryOptions.original() {
    return QueryOptions(QueryOptionsSort.NAME, QueryOptionsOrder.ASCENDING,
        QueryOptionsLimit.ALL, 0);
  }

  Map toJson() {
    return this.toMap();
  }

  QueryOptions copyWith(
      {sortOption, orderOption, limitOption, limitOptionData}) {
    return QueryOptions(sortOption, orderOption, limitOption, limitOptionData);
  }

  factory QueryOptions.fromJson(Map searchOptions) {
    Map<String, dynamic> halfwayParsed = Map.castFrom(searchOptions);
    return QueryOptions.fromMap(halfwayParsed);
  }

  /// Parse back to store data format
  factory QueryOptions.fromMap(Map<String, dynamic> searchOptions) {
    // Sort Option
    QueryOptionsSort sortOption;
    if (searchOptions["sortOption"] == "start") {
      sortOption = QueryOptionsSort.START;
    } else if (searchOptions["sortOption"] == "end") {
      sortOption = QueryOptionsSort.END;
    } else {
      sortOption = QueryOptionsSort.NAME;
    }

    // Order Option
    QueryOptionsOrder orderOption;
    if (searchOptions["orderOption"] == "descending") {
      orderOption = QueryOptionsOrder.DESCENDING;
    } else {
      orderOption = QueryOptionsOrder.ASCENDING;
    }

    // Limit Option
    QueryOptionsLimit limitOption;
    int limitOptionData;
    if (searchOptions["limitOption"] == "limit") {
      limitOption = QueryOptionsLimit.LIMIT;
      limitOptionData = int.parse(searchOptions["limitOptionData"]);
    } else {
      limitOption = QueryOptionsLimit.ALL;
      limitOptionData = 0;
    }

    return QueryOptions(sortOption, orderOption, limitOption, limitOptionData);
  }

  Map<String, dynamic> toMap() {
    // Parse all data to a map to be used in dialog
    // or using store data directly here
    Map<String, dynamic> parsedSearchOptions = {};

    // Sort data
    switch (this.sortOption) {
      case QueryOptionsSort.START:
        parsedSearchOptions["sortOption"] = "start";
        break;
      case QueryOptionsSort.END:
        parsedSearchOptions["sortOption"] = "end";
        break;
      default:
        parsedSearchOptions["sortOption"] = "name";
    }

    // Order data
    switch (this.orderOption) {
      case QueryOptionsOrder.DESCENDING:
        parsedSearchOptions["orderOption"] = "descending";
        break;
      default:
        parsedSearchOptions["orderOption"] = "ascending";
    }

    // Limit data
    switch (this.limitOption) {
      case QueryOptionsLimit.LIMIT:
        parsedSearchOptions["limitOption"] = "limit";
        parsedSearchOptions["limitOptionData"] =
            this.limitOptionData.toString();
        break;
      default:
        parsedSearchOptions["limitOption"] = "all";
        parsedSearchOptions["limitOptionData"] = "10";
    }

    // Factory return
    return parsedSearchOptions;
  }
}
