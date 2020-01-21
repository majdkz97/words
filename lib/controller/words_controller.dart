
import 'package:dart_server/dart_server.dart';

class WordsController extends ResourceController {

  final _words = [
    {'word':'horse'},
    {'word':'cow'},
    {'word':'cat'},
    {'word':'car'},
    {'word':'laptop'},
  ];

  @Operation.get()
  Future<Response> getAllWords() async {
    return Response.ok(_words);
  }

  @Operation.get('id')
  Future<Response> getWordById(@Bind.path('id') int id) async {

    return Response.ok(_words[id]);
  }

  @Operation.post()
  Future<Response> addWord() async{
    return Response.ok('Post Successfully');
  }

  @Operation.put('id')
  Future<Response> updateWord(@Bind.path('id') int id) async{
    return Response.ok('Put Successfully');
  }


  @Operation.delete('id')
  Future<Response> deleteWord(@Bind.path('id') int id) async{
    return Response.ok('Delete Successfully');
  }

}