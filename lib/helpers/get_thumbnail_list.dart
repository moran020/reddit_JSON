import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getThumbnailList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<String> thumbnail = [];
    for (var i in jsonResponse['data']['children']) {
      thumbnail.add(i['data']['thumbnail']);
    }
    return thumbnail;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
