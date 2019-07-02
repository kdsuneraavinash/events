import 'package:event_app/state/event.dart';

/// Comparator for sorting.
/// Will first compare first value.
/// If it is equal, will compare second value.
int _compareEventValues(List a, List b) {
  // First Compare main value
  if (a[0] > b[0])
    return 1;
  else if (a[0] < b[0])
    return -1;
  else {
    // If same compare sub value
    if (a[1] > b[1])
      return 1;
    else if (a[1] < b[1])
      return -1;
    else
      return 0;
  }
}

/// Sort event list according to a search string.
List<Event> getSortedEventList(String searchString, List<Event> eventList) {
  List<List> helperList = [];
  for (Event event in eventList) {
    List similarityPoints = _getTotalSimilarityPoints(
        searchString.toLowerCase(), event.eventName.toLowerCase());
    List<dynamic> keyedList = [similarityPoints[0], similarityPoints[1], event];
    helperList.add(keyedList);
  }

  helperList.sort(_compareEventValues);

  List<Event> result = [];
  for (List internal in helperList) {
    result.add(internal[2]);
  }

  return result.reversed.toList();
}

/// Similarity points are sum of percentages of euality
/// of each permuation of pairs of words.
List<double> _getTotalSimilarityPoints(String s, String t) {
  List<String> s_words = s.split(" ");
  List<String> t_words = t.split(" ");
  double total_dist = 0.0;
  for (String s_word in s_words) {
    for (String t_word in t_words) {
      double dist = _levenshteinDistancePercentage(s_word, t_word);
      if (dist < 50) continue;
      total_dist += dist;
    }
  }
  return [total_dist, _levenshteinDistancePercentage(s, t)];
}

/// Get levenshteinDistance as persentage of longest
double _levenshteinDistancePercentage(String s, String t) {
  int longestLen = s.length > t.length ? s.length : t.length;
  return (1 - _levenshteinDistance(s, t) / longestLen) * 100;
}

/// Get minimum distance between 2 strings.
int _levenshteinDistance(String s, String t) {
  // Minimum function
  var min = (int p, int q) => p > q ? q : p;
  // for all i and j, d[i,j] will hold the Levenshtein distance between
  // the first i characters of s and the first j characters of t
  // note that d has (m+1)*(n+1) values
  int m = s.length;
  int n = t.length;
  // Each element value is 0
  List<List<int>> d = List.generate(m + 1, (_) => List.filled(n + 1, 0));

  // source prefixes can be transformed into empty string by
  // dropping all characters
  for (int i = 0; i < m + 1; i++) {
    d[i][0] = i;
  }

  // target prefixes can be reached from empty source prefix
  // by inserting every character
  for (int j = 0; j < n + 1; j++) {
    d[0][j] = j;
  }

  for (int j = 1; j < n + 1; j++) {
    for (int i = 1; i < m + 1; i++) {
      int substitutionCost = 0;
      if (s[i - 1] == t[j - 1]) {
        substitutionCost = 0;
      } else {
        substitutionCost = 1;
      }
      d[i][j] = [
        d[i - 1][j] + 1,
        d[i][j - 1] + 1,
        d[i - 1][j - 1] + substitutionCost
      ].reduce(min);
    }
  }
  return d[m][n];
}
