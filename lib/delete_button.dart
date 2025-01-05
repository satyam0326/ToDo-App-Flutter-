import 'package:flutter/material.dart';
import 'package:to_do_app/api_services.dart';
import 'package:to_do_app/commontoast.dart';
import 'package:to_do_app/todoscreen.dart';

class DeleteButton extends StatefulWidget {
  final String id;
  final VoidCallback onDeleteSuccess;

  const DeleteButton(
      {super.key, required this.id, required this.onDeleteSuccess});

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isloading = true;
        });
        try {
          await ApiServices().deletetodo(widget.id);
          commonToast(context, 'Delete Successfully', bgColor: Colors.green);
          widget.onDeleteSuccess();
        } catch (error) {
          debugPrint(error.toString());
          commonToast(context, 'Something went wrong');
        } finally {
          setState(() {
            isloading = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 132, 123, 155).withOpacity(.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: isloading
            ? CircularProgressIndicator()
            : Icon(Icons.delete_outline, color: Colors.redAccent),
      ),
    );
  }
}
