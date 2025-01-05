import 'package:flutter/material.dart';
import 'package:to_do_app/add_update.dart';
import 'package:to_do_app/add_update_screen.dart';
import 'package:to_do_app/delete_button.dart';
import 'package:to_do_app/api_services.dart';
import 'package:to_do_app/get_all_todo.dart';

class Todoscreen extends StatefulWidget {
  final List<Item> todoList;
  final Function(String id) onDelete; // Add this callback

  const Todoscreen({super.key, required this.todoList, required this.onDelete});

  @override
  _TodoscreenState createState() => _TodoscreenState();
}

class _TodoscreenState extends State<Todoscreen> {
  List<Item> todoList = [];

  @override
  void initState() {
    super.initState();
    todoList = widget.todoList;
  }

  void _removeItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
    widget.onDelete(id); // Notify parent widget
  }

  @override
  Widget build(BuildContext context) {
    return todoList.isEmpty
        ? Center(child: Text('This ToDo tab is empty'))
        : ListView.separated(
            itemBuilder: (context, index) {
              final item = todoList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUpdate(item: item),
                    ),
                  );
                },
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title ?? "No Title",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    item.description ?? "No Description",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                            DeleteButton(
                              id: item.id ?? "",
                              onDeleteSuccess: () => _removeItem(item.id ?? ""),
                            ),
                          ],
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 132, 123, 155)
                                .withOpacity(.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            item.isCompleted == true
                                ? "Complete"
                                : "Incomplete",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, i) => const SizedBox(
              height: 10,
            ),
            itemCount: todoList.length,
          );
  }
}
