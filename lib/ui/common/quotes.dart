import 'dart:math';

import 'package:flutter/material.dart';

final Map<String, String> quotes = {
  '${"Frugality includes all the other virtues."}': 'Cicero',
  '${"An investment in knowledge pays the best interest."}':
      'Benjamin Franklin',
  '${"Money is a terrible master but an excellent servant."}': 'P.T. Barnum',
  '${"Wealth is the ability to fully experience life."}': 'Henry David Thoreau',
  '${"Never spend your money before you have it."}': 'Thomas Jefferson',
};

Random random = Random();
var keys = quotes.keys.toList(); // Convert keys to a list
var randomQuote = keys[random.nextInt(keys.length)];
var randomAuthor = quotes[randomQuote];
