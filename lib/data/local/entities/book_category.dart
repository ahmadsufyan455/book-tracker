import 'package:floor/floor.dart';

@Entity(tableName: 'category')
class BookCategory {
  @primaryKey
  final int? id;
  @ColumnInfo(name: 'name')
  final String name;

  BookCategory({this.id, required this.name});
}
