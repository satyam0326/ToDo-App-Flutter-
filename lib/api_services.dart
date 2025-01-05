import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:to_do_app/get_all_todo.dart';
import 'package:to_do_app/todomodel.dart';

class ApiServices {
  final String baseurl = "https://api.nstack.in";

  Map<String, String> get headers => {"Content-Type": "application/json"};

  Future<Model> getalltodo() async {
    var response = await http.get(Uri.parse('$baseurl/v1/todos'));
    if (response.statusCode == 200) {
      print('Get All Todos Response: ${response.body}');
      return Model.fromJson(jsonDecode(response.body));
    } else {
      print('Failed to get todos: ${response.body}');
      throw Exception('Failed to get todos: ${response.statusCode}');
    }
  }

  Future<ToDoModel> add(
      String title, String description, bool isComplete) async {
    try {
      final response = await http.post(
        Uri.parse('$baseurl/v1/todos'),
        headers: headers,
        body: jsonEncode({
          "title": title,
          "description": description,
          "is_completed": isComplete,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Add Todo Response: ${response.body}');
        return ToDoModel.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to add todo: ${response.body}');
        throw Exception('Failed to add todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error adding todo: $e');
    }
  }

  Future<ToDoModel> update(
      String id, String title, String description, bool isComplete) async {
    try {
      final response = await http.put(
        Uri.parse('$baseurl/v1/todos/$id'),
        headers: headers,
        body: jsonEncode({
          "title": title,
          "description": description,
          "is_completed": isComplete,
        }),
      );

      if (response.statusCode == 200) {
        print('Update Todo Response: ${response.body}');
        return ToDoModel.fromJson(jsonDecode(response.body));
      } else {
        print('Failed to update todo: ${response.body}');
        throw Exception('Failed to update todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }

  Future<bool> deletetodo(String id) async {
    final response = await http.delete(Uri.parse('$baseurl/v1/todos/$id'));
    if (response.statusCode == 200) {
      print('Delete Todo Response: ${response.body}');
      return true;
    } else {
      print('Failed to delete todo: ${response.body}');
      throw Exception('Failed to delete todo: ${response.statusCode}');
    }
  }
}
