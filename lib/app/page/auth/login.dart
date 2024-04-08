import 'package:app_provider/app/data/api.dart';
import 'package:app_provider/app/page/detail.dart';
import 'package:app_provider/mainpage.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _accountController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
     login() async {
      //lấy token (lưu share_preference)
      String token = await APIRepository().login(_accountController.text, _passwordController.text);
      var user = await APIRepository().current(token);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Mainpage(user: user)));
     return token;
    }
    return  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                  controller: _accountController,
                  decoration: const InputDecoration(
                    labelText: "Account",
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: 
                  OutlinedButton(onPressed: login, child: Text("Login")))
                ],
              )
            ],
          ),
        ),
    );
  }
}