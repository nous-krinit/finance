import 'package:flutter/foundation.dart';
import 'package:my_finance/models/transaction.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:stacked/stacked.dart';
import '../models/category.dart';

const String DB_NAME = 'transaction_database.sqlite';
const String CategoryTable = 'categories';
const String TransactionTable = 'transactions';

class DatabaseService with ListenableServiceMixin {
  DatabaseService() {
    listenToReactiveValues([_cachedCategories]);
    listenToReactiveValues([_cachedTransactions]);
  }
  late Database _database;
  List<TxCategory> _cachedCategories = [];
  List<AppTransaction> _cachedTransactions = [];

  /// Initialize database and assign it to `_database`
  Future<void> initialise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE categories(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT UNIQUE,
          icon TEXT,
          color INTEGER
        )
      ''');
        db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount INTEGER,
          type TEXT,
          category TEXT,
          date TEXT,
          note TEXT
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
        CREATE TABLE transactions(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          amount INTEGER,
          type TEXT,
          category TEXT,
          date TEXT,
          note TEXT
        )
      ''');
        }
      },
      version: 2,
    );
  }

  Future<List<TxCategory>> getCategories() async {
    final db = _database;
    final count = Sqflite.firstIntValue(
            await db.rawQuery('SELECT COUNT(*) FROM $CategoryTable')) ??
        0;

    if (count == 0) {
      // Insert initial categories
      List<Map<String, dynamic>> initialCategories = [
        {
          'name': 'Food',
          'icon': 'F736',
          'color': 4294956800,
        },
        {
          'name': 'Education',
          'icon': 'E0EF',
          'color': 4278239231,
        },
        {
          'name': 'Transportation',
          'icon': 'E1D7',
          'color': 4281990932,
        },
        {
          'name': 'Health',
          'icon': 'F7DF',
          'color': 4278255615,
        },
        {
          'name': 'Gift',
          'icon': 'F61A',
          ''
              'color': 04294919424
        },
        {
          'name': 'Apparel',
          'icon': 'F016F',
          'color': 4281519410,
        },
        {
          'name': 'Entertainment',
          'icon': 'F8E5',
          'Color': 4294967040,
        },
      ];

      for (var category in initialCategories) {
        await db.insert(CategoryTable, category);
      }
    }

    final categoryResults = await db.query(CategoryTable);

    _cachedCategories = categoryResults.map((category) {
      return TxCategory(
        id: category['id'] as int?,
        name: category['name'] as String,
        icon: category['icon'] as String,
        color: category['color'] as int,
      );
    }).toList();

    return _cachedCategories;
  }

  List<TxCategory> getCachedCategories() {
    Future.microtask(() => notifyListeners());
    return _cachedCategories; // Return tasks from memory
  }

  Future<void> addCategory(TxCategory category) async {
    await _database.insert(
      CategoryTable,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteCategory(TxCategory category) async {
    await _database.delete(
      CategoryTable,
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  Future<List<AppTransaction>> getTransactions() async {
    final db = _database;
    final transactionResults = await db.query(TransactionTable);
    _cachedTransactions = transactionResults.map((transaction) {
      return AppTransaction(
        id: transaction['id'] as int?,
        amount: transaction['amount'] as int,
        type: transaction['type'] as String,
        category: transaction['category'] as String,
        date: transaction['date'] as String,
        note: transaction['note'] as String?,
      );
    }).toList();

    return _cachedTransactions;
  }

  List<AppTransaction> getCachedTransactions() {
    Future.microtask(() => notifyListeners());
    return _cachedTransactions; // Return tasks from memory
  }

  Future<void> addTransaction(AppTransaction transaction) async {
    await _database.insert(
      TransactionTable,
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTransaction(AppTransaction transaction) async {
    await _database.delete(
      TransactionTable,
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  Future<void> updateTransaction(AppTransaction transaction) async {
    await _database.update(
      TransactionTable,
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }
  Future<void> updateCategory(TxCategory category) async {
    await _database.update(
      CategoryTable,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

}
