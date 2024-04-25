import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'models/searchModel.dart';

Future<void> fetchDataAndSaveLocally() async {
  try {
    final response = await http
        .get(Uri.parse('https://codewithandrea.com/search/search.json'));
    if (response.statusCode == 200) {
      // Get the application directory
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/searchList.json');
      // Write data to file
      await file.writeAsString(response.body, flush: true);
    }
  } catch (e) {
    print("Failed to fetch data: $e");
  }
}

Future readDataFromLocalFile() async {
  try {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/searchList.json');
    if (await file.exists()) {
      String data = await file.readAsString();
      List<dynamic> results = json.decode(data)['results'];
      return results.map((data) => Search.fromJson(data)).toList();
    } else {
      print('No local data found!');
    }
  } catch (e) {
    throw Exception('Failed to read local data: $e');
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Handling',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Items with Local Fallback'),
        ),
        body: FutureBuilder(
          future:
              fetchDataAndSaveLocally().then((_) => readDataFromLocalFile()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data![index];
                  return ListTile(
                    title: Text(item.title),
                    subtitle: Text(item.url),
                    trailing: Text(item.date),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
