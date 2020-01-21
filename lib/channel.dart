import 'package:dart_server/controller/words_controller.dart';

import 'dart_server.dart';

class DartServerChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final config = WordsConfig(options.configurationFilePath);
    final database = PostgreSQLPersistentStore.fromConnectionInfo(
      config.database.username,
      config.database.password,
      config.database.host,
      config.database.port,
      config.database.databaseName
    );
    context = ManagedContext(dataModel,database);

  }

  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/words/[:id]")
      .link(() => WordsController(context));

    return router;
  }
}

class WordsConfig extends Configuration {
  WordsConfig(String path) : super.fromFile(File(path));
  DatabaseConfiguration database;
}