import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb {

  static Database? _db ; 

  Future<Database?> get db async{
    if (_db == null ) {
      _db = await initialDb();
      return _db ;
    }else{
      return _db ; 
    }
  }

  initialDb()async{
    String databasepath = await getDatabasesPath();
    String path = join(databasepath,"to_do_list.db");
    Database mydb = await openDatabase( path,onCreate: _onCreate,version: 1);
  }
  _onCreate(Database db , int version)async{
    await db.execute('''
  CREATE TABLE "TODOLISTAPP" (
    id INTEGER AUTOINCREMANTE NOT NULL PRUMARY KEY ,
    data TEXT NOT NULL ,
    time DATE NOT NULL ,
  )
''');
print("====== CREATE DATABAE AND TABLE =======");
  }
  readData(String sql )async{
    Database? mydb = await db ;
    List<Map> response = await mydb!.rawQuery(sql);
    return response ;
  }

insertData(String sql )async{
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response ;
  }

  updateData(String sql )async{
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response ;
  }

  deleteData(String sql )async{
    Database? mydb = await db ;
    int response = await mydb!.rawDelete(sql);
    return response ;
  }

}
