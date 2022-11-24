import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  const MyButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            CircleAvatar(
                radius: 13,
                child: Icon(
                  Icons.add,
                  size: 15,
                )),
            SizedBox(
              width: 8,
            ),
            Text(
              "Tambah Habit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
