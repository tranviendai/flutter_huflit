import 'package:app_api/app/data/api.dart';
import '../register.dart';
import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController accountController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    login() async {
      //lấy token (lưu share_preference)
      String token = await APIRepository()
          .login(accountController.text, passwordController.text);
      var user = await APIRepository().current(token);
      // save share
      saveUser(user);
      //
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
      return token;
    }

    @override
  void initState() {
    super.initState();
    autoRoute();
  }
  //này có thể ở phần main.dart
  autoRoute() async {
    var pref = await SharedPreferences.getInstance();
    if(pref.getString('user')!.length > 10){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Mainpage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                const Image(
                  image: NetworkImage(
                      "https://drive.google.com/uc?export=view&id=1oqMqmNpPf4Q7iXGsQ50v4atHZ6yCmhfE"),
                  height: 200,
                  width: 200,
                ),
                const Text(
                  "LOGIN INFORMATION",
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
                TextFormField(
                  controller: accountController,
                  decoration: const InputDecoration(
                    labelText: "Account",
                    icon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                      onPressed: login,
                      child: const Text("Login"),
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Text("Register"),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


