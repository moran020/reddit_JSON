import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getTitleList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<String> title = [];
    for (var i in jsonResponse['data']['children']) {
      title.add(i['data']['title']);
    }
    return title;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
