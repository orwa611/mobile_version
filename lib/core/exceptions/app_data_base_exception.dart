abstract class AppDataBaseException implements Exception {
  String message;

  AppDataBaseException(this.message);
}

final class DataBaseNotOpenException extends AppDataBaseException {
  DataBaseNotOpenException() : super('Database can\'t be opened!');
}

final class DataBaseNotFoundException extends AppDataBaseException {
  DataBaseNotFoundException() : super('Database instance not found!');
}

final class DataBaseInsertionException extends AppDataBaseException {
  DataBaseInsertionException() : super('Database Insertion occured!');
}

final class DataBaseQueryException extends AppDataBaseException {
  DataBaseQueryException()
    : super('Database Can not retreive data error occured!');
}

final class DataBaseDaletionException extends AppDataBaseException {
  DataBaseDaletionException(dynamic data)
    : super('Database Can not delete data error occured! $data');
}
