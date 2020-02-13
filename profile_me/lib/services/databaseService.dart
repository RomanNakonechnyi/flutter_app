import 'package:profile_me/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService{
  static DatabaseService _instance;
  static Future<DatabaseService> getInstance() async {
    if (_instance == null) {
      _instance = DatabaseService();
    }
    return _instance;
  }

   static const _dbName = 'user_database.db';

  Future<Database> getDatabase()async{
    print(join(await getDatabasesPath(), _dbName));
    return openDatabase(join(await getDatabasesPath(),_dbName),
    onCreate: (db,version){
          return db.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fullname TEXT, password TEXT, login TEXT)",
          );
    },
    version: 1);
  }

  Future<void> createUser(User user) async{
    final Database db = await getDatabase();


    await db.insert(
      'users',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUsers() async {
    // Get a reference to the database.
    final Database db = await getDatabase();

    // Query the table for all The Users.
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convert the List<Map<String, dynamic> into a List<User>.
    return List.generate(maps.length, (i) {
      return User.fromJson(maps[i]);
    });
  }
}