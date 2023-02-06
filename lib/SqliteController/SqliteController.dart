import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter_sqlite1/models/model.dart';

late Database database;

const DB_NAME = 'studentFinal_database.db';
const TABLE_NAME = 'studentFinal';

class SQLiteController {
  Future<void> initializeDatabase() async {
    // Avoid errors caused by flutter upgrade.
    // Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.

    database = await openDatabase(
      join(await getDatabasesPath(), DB_NAME),
    );

    database.execute(
      'CREATE TABLE IF NOT EXISTS $TABLE_NAME (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER, phone INTEGER)',
    );
  }

// Define a function that inserts dogs into the database
  Future<void> insertStudent(Student student) async {
    // Get a reference to the datbase.
    final db = await database;

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    // await db.insert(
    //   'dogs',
    //   dog.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.ignore,
    // );

    await db.rawInsert(
        'INSERT INTO $TABLE_NAME (name,age,phone) VALUES (\'${student.name}\',\'${student.age}\',\'${student.phone}\')');
  }

// A method that retrieves all the dogs from the dogs table.
  Future<List<Student>> students() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    //final List<Map<String, dynamic>> maps = await db.query('dogs');

    final List<Map<String, dynamic>> maps =
        await db.rawQuery('Select * from $TABLE_NAME');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Student(
        id: maps[i]["id"],
        name: maps[i]['name'],
        age: maps[i]['age'],
        phone: maps[i]['phone'],
      );
    });
  }

  Future<void> updateStudent(Student student) async {
    // Get a reference to the database.
    final db = await database;
    await db.update(
      TABLE_NAME,
      student.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [student.id],
    );
    // db.rawUpdate(
    //     'update student set name ="${student.name}" where id = ${student.id}');
  }
  // Update the given Dog.

  // UPDATE dogs SET name = 'milu' WHERE id = 1

  // await db.update(
  //   TABLE_NAME,
  //   student.toMap(),
  //   // Ensure that the Dog has a matching id.
  //   where: 'name = ?',
  //   // Pass the Dog's id as a whereArg to prevent SQL injection.
  //   whereArgs: [student.name],
  // );
  Future<void> deleteStudent(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      TABLE_NAME,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
