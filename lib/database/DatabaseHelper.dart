import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static final int version = 1;
  static Database _db;
  final String _dbName = 'Servicing.db';

  Future<Database> get database async {
    if (_db != null) return _db;

    // if _db is null, we instantiate it
    _db = await initDB();
    return _db;
  }

  Future<bool> checkIfDbExists() async {
    String path = join(await getDatabasesPath(), _dbName);
    return new File(path).exists();
  }

  Future initDB() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(
      path,
      version: version,
      onOpen: _onOpenDB,
      onCreate: _onCreateDB,
      onUpgrade: _onUpgradeDB,
    );
  }

  FutureOr<void> _onOpenDB(Database db) async {
    print('db version ${await db.getVersion()}');
  }

  FutureOr<void> _onCreateDB(Database db, int version) async {
    var dbBatch = db.batch();
    // version 1
//    dbBatch.execute(_createTablePersonSql());

    // version 2
//    dbBatch.execute(_createTablePersonOutSql());

    await dbBatch.commit(noResult: true);
    print('version $version');
  }

  FutureOr<void> _onUpgradeDB(Database db, currentVersion, newVersion) async {
    print('currentVersion $currentVersion newVersion $newVersion');
    final upgradeCalls = {
//      2: (Database db, Batch dbBatch) async {
//        print('upgrade 2');
//        // add upgrade script
//        // dbBatch.execute(_updateTablePersonHistoryAddTimeSql());
//      },
//      3: (Database db, Batch dbBatch) async {
//        print('upgrade 3');
//        dbBatch.execute(_createTablePersonOutSql());
//      },
    };
    var dbBatch = db.batch();
    upgradeCalls.forEach((version, call) async {
      if (version > currentVersion) {
        await call(db, dbBatch);
      }
    });
    await dbBatch.commit(noResult: true);
  }
}