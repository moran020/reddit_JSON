import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<String>> getSelftextList() async {
  const url = 'https://reddit.com/r/flutterdev/new.json';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    List<String> selftext = [];
    for (var i in jsonResponse['data']['children']) {
      selftext.add(i['data']['selftext']);
    }
    return selftext;
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
