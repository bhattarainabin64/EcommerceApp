import 'package:flutter/material.dart';

class ErrorSnakbar extends StatelessWidget {
  const ErrorSnakbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 90,
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.error_outline,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Success",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              SizedBox(height: 7),
              Text(
                "Your account has been created",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ))
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 240, 3, 14),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
