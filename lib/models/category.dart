import 'dart:core';

import 'package:flutter/widgets.dart';

class TxCategory {
  int? id;
  String name;
  String icon;
  int color;

  TxCategory({
    this.id,
    required this.name,
    required this.icon,
    required this.color,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  @override
  String toString() {
    return 'TxCategory{id: $id, name: $name, icon: $icon, color: $color,}';
  }
}
