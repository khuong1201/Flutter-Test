import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact_model.dart';

class ContactLocalDataSource {
  static Database? _db;

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'contacts.db');

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, phone TEXT)",
        );
      },
    );

    await _insertSampleData(db);

    return db;
  }

  Future<void> _insertSampleData(Database db) async {
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM contacts')) ?? 0;
    if (count == 0) {
      await db.transaction((txn) async {
        await txn.insert('contacts', {'name': 'Alice', 'email': 'alice@mail.com', 'phone': '123456789'});
        await txn.insert('contacts', {'name': 'Bob', 'email': 'bob@mail.com', 'phone': '987654321'});
        await txn.insert('contacts', {'name': 'Charlie', 'email': 'charlie@mail.com', 'phone': '555666777'});
      });
    }
  }

  Future<List<ContactModel>> getContacts() async {
    final db = await database;
    final result = await db.query('contacts');
    return result.map((map) => ContactModel.fromMap(map)).toList();
  }

  Future<void> insertContact(ContactModel contact) async {
    final db = await database;
    await db.insert('contacts', contact.toMap());
  }

  Future<void> updateContact(ContactModel contact) async {
    final db = await database;
    await db.update('contacts', contact.toMap(), where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }
}
