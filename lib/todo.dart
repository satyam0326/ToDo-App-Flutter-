import 'package:flutter/material.dart';
import 'package:to_do_app/add_update.dart';
import 'package:to_do_app/api_services.dart';
import 'package:to_do_app/get_all_todo.dart';
import 'package:to_do_app/todoscreen.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  Model model = Model();
  List<Item> incompletetodo = [];
  List<Item> completetodo = [];
  bool isloading = false;

  getalltodos() async {
    setState(() {
      isloading = true;
      model.items?.clear();
      incompletetodo.clear();
      completetodo.clear();
    });
    try {
      var value = await ApiServices().getalltodo();
      for (var todo in value.items!) {
        if (todo.isCompleted == true) {
          completetodo.add(todo);
        } else {
          incompletetodo.add(todo);
        }
      }
      setState(() {
        model = value;
        isloading = false;
      });
    } catch (error) {
      debugPrint(error.toString());
      setState(() {
        isloading = false;
      });
    }
  }

  // Method to delete an item from all lists
  void deleteTodoItem(String id) {
    setState(() {
      // Remove from all lists
      model.items?.removeWhere((item) => item.id == id);
      incompletetodo.removeWhere((item) => item.id == id);
      completetodo.removeWhere((item) => item.id == id);
    });
  }

  @override
  void initState() {
    super.initState();
    getalltodos();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 163, 141, 223),
          title: Text('ToDo List'),
          centerTitle: true,
          bottom: TabBar(
            labelPadding: EdgeInsets.symmetric(vertical: 10),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
            tabs: [
              Text('All'),
              Text('Incomplete'),
              Text('Complete'),
            ],
          ),
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  Todoscreen(
                    todoList: model.items ?? [],
                    onDelete: deleteTodoItem,
                  ),
                  Todoscreen(
                    todoList: incompletetodo,
                    onDelete: deleteTodoItem,
                  ),
                  Todoscreen(
                    todoList: completetodo,
                    onDelete: deleteTodoItem,
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddUpdate()));
            getalltodos();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
