import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          width: 150,
          padding: EdgeInsets.all(10),
          color: Colors.blueGrey.shade100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                  backgroundColor: Colors.blueGrey,
                ),
              ),
              SizedBox(width: 15),
              Text("Loading...", style: TextStyle(fontSize: 18, color: Colors.black54)),
            ],
          ),
        )
    );
  }
}
