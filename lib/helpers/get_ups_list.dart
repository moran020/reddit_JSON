import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<int>> getUpsList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<int> ups = [];
    for (var i in jsonResponse['data']['children']) {
      ups.add(i['data']['ups']);
    }
    return ups;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
