import 'package:flutter/material.dart';
import 'package:to_do_app/api_services.dart';
import 'package:to_do_app/commontoast.dart';
import 'package:to_do_app/get_all_todo.dart';
import 'package:to_do_app/todoscreen.dart';

class AddUpdate extends StatefulWidget {
  final Item? item;
  const AddUpdate({super.key, this.item});

  @override
  _AddUpdateState createState() => _AddUpdateState();
}

class _AddUpdateState extends State<AddUpdate> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  bool isComplete = false;
  bool isloading = false;
  @override
  void initState() {
    if (widget.item != null) {
      title.text = widget.item?.title ?? "";
      description.text = widget.item?.description ?? "";
      isComplete = widget.item?.isCompleted ?? false;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item == null ? 'Add ToDo' : "Update ToDo"),
        backgroundColor: const Color.fromARGB(255, 135, 122, 173),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: title,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              decoration:
                  InputDecoration(hintText: 'Title', border: InputBorder.none),
            ),
            TextFormField(
              controller: description,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              decoration: InputDecoration(
                  hintText: 'Description', border: InputBorder.none),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Complete',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Switch(
                  value: isComplete,
                  activeColor: Colors.deepPurple,
                  onChanged: (bool value) {
                    setState(() {
                      isComplete = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (title.text.isEmpty) {
            commonToast(context, 'Please Enter Title');
          } else if (description.text.isEmpty) {
            commonToast(context, 'Please Enter Description');
          } else {
            setState(() {
              isloading = true;
            });

            if (widget.item == null) {
              ApiServices()
                  .add(title.text.toString(), description.text.toString(),
                      isComplete)
                  .then((value) {
                isloading = false;
                Navigator.pop(context, true);
              }).onError((error, stackTrace) {
                debugPrint(error.toString());
                setState(() {
                  isloading = false;
                });
                commonToast(context, 'Something went wrong');
              });
            } else {
              ApiServices()
                  .update(widget.item!.id!, title.text.toString(),
                      description.text.toString(), isComplete)
                  .then((value) {
                isloading = false;
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Todoscreen(
                              todoList: [],
                              onDelete: (String id) {},
                            )));
              }).onError((error, stackTrace) {
                debugPrint(error.toString());
                setState(() {
                  isloading = false;
                });
                commonToast(context, 'Something went wrong');
              });
            }
          }
        },
        child: isloading ? CircularProgressIndicator() : Icon(Icons.done),
      ),
    );
  }
}
