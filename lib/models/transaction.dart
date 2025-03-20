import 'dart:core';

class AppTransaction {
  int? id;
  int amount;
  String type;
  String category;
  String date;
  String? note;

  AppTransaction(
      {this.id,
      required this.amount,
      required this.type,
      required this.category,
      required this.date,
      this.note});

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'category': category,
      'date': date,
      'note': note
    };
  }

  @override
  String toString() {
    return 'AppTransaction{id: $id, amount: $amount,type: $type, category: $category, date: $date, note: $note}';
  }
}
