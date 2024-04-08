import 'package:flutter/material.dart';
import '../model/user.dart';

class Detail extends StatelessWidget {
  const Detail({super.key, required this.user});
  final User user;
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  @override
  Widget build(BuildContext context) {
    // create style
    TextStyle mystyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.amber,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image(image: NetworkImage(user.imageUrl!), height: 250),
            Text("NumberID: ${user.idNumber}", style: mystyle),
            Text("Fullname: ${user.fullName}", style: mystyle),
            Text("Phone Number: ${user.phoneNumber}", style: mystyle),
            Text("Gender: ${user.gender}", style: mystyle),
            Text("birthDay: ${user.birthDay}", style: mystyle),
            Text("schoolYear: ${user.schoolYear}", style: mystyle),
            Text("schoolKey: ${user.schoolKey}", style: mystyle),
            Text("dateCreated: ${user.dateCreated}", style: mystyle),
          ]),
        ),
      ),
    );
  }
}
