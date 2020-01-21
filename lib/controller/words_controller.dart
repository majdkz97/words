import 'package:dart_server/dart_server.dart';
import 'package:dart_server/model/word.dart';

class WordsController extends ResourceController {
  WordsController(this.context);
  ManagedContext context;

  @Operation.get()
  Future<Response> getAllWords({@Bind.query('q') String prefix}) async {
    final query = Query<Word>(context);
    if(prefix!=null){
      query.where((w)=>w.word).beginsWith(prefix,caseSensitive: true);
    }
    query..sortBy((w) => w.word, QuerySortOrder.ascending)..fetchLimit = 10;
    final wordList = await query.fetch();
    return Response.ok(wordList);
  }

  @Operation.get('id')
  Future<Response> getWordById(@Bind.path('id') int id) async {
    final query = Query<Word>(context)
    ..where((x) => x.id).equalTo(id);
    final wordList = await query.fetchOne();
    return Response.ok(wordList);
  }

  @Operation.post()
  Future<Response> addWord(@Bind.body(ignore: ['id']) Word newWord) async {
    final query = Query<Word>(context)
    ..values = newWord;
    final insertWord = await query.insert();

    return Response.ok(insertWord);
  }

  @Operation.put('id')
  Future<Response> updateWord(@Bind.path('id') int id,
      @Bind.body(ignore: ['id']) Word userUpdate) async {
    final query = Query<Word>(context)
    ..values = userUpdate
    ..where((x)=>x.id).equalTo(id);
    final updatedWord = await query.updateOne();
    return Response.ok(updatedWord);
  }

  @Operation.delete('id')
  Future<Response> deleteWord(@Bind.path('id') int id) async {
    final query = Query<Word>(context)
    ..where((w)=>w.id).equalTo(id);
    final wordDeleted = await query.delete();
    final message = {'message':'Deleted $wordDeleted Word(s)'};
    return Response.ok (message);
  }
}
