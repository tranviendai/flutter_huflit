import 'package:app_provider/app/data/api.dart';
import 'package:app_provider/app/model/register.dart';
import 'package:app_provider/app/page/auth/login.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'detail.dart';

class Register extends StatefulWidget {
  final User user;
  const Register({super.key, required this.user});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // bool _checkvalue_1 = false;
  // bool _checkvalue_2 = false;
  // bool _checkvalue_3 = false;
  int _gender = 0;
  final _accountController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _numberIDController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _schoolKeyController = TextEditingController();
  final _schoolYearController = TextEditingController();
  final _birthDayController = TextEditingController();
  String gendername = 'None';
  bool checkRegister = true;

  Future<String> register(String gender) async {
   return await APIRepository().register(Signup(
      accountID: _accountController.text,
      birthDay: _birthDayController.text,
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
      fullName: _fullNameController.text,
      phoneNumber: _phoneNumberController.text,
      schoolKey: _schoolKeyController.text,
      schoolYear: _schoolYearController.text,
      gender: gender,
      imageUrl: '', //-> image file o day
      numberID: _numberIDController.text
    ));
  }

  @override
  Widget build(BuildContext context) {
    return  widget.user.accountId != '' ? Detail(user: widget.user) : Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child:  Text(
                  !checkRegister ? 'Login' : 'User Information',
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
             !checkRegister? LoginScreen() : signUpWidget(),
              // const Text("What is your Favorite?"),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     Expanded(
              //       child: CheckboxListTile(
              //         controlAffinity: ListTileControlAffinity.leading,
              //         contentPadding: EdgeInsets.all(0),
              //         title: const Text("Music"),
              //         value: _checkvalue_1,
              //         onChanged: (value) {
              //           setState(() {
              //             _checkvalue_1 = value!;
              //           });
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: CheckboxListTile(
              //         controlAffinity: ListTileControlAffinity.leading,
              //         title: const Text("Movie"),
              //         contentPadding: EdgeInsets.all(0),
              //         value: _checkvalue_2,
              //         onChanged: (value) {
              //           setState(() {
              //             _checkvalue_2 = value!;
              //           });
              //         },
              //       ),
              //     ),
              //     Expanded(
              //       child: CheckboxListTile(
              //         controlAffinity: ListTileControlAffinity.leading,
              //         title: const Text("Book"),
              //         contentPadding: EdgeInsets.all(0),
              //         value: _checkvalue_3,
              //         onChanged: (value) {
              //           setState(() {
              //             _checkvalue_3 = value!;
              //           });
              //         },
              //       ),
              //     ),
              //   ],
              // ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
               !checkRegister? SizedBox() :  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_gender == 1) {
                          setState(() {
                            gendername = "Male";
                          });
                        } else if (_gender == 2) {
                         setState(() {
                            gendername = "Female";
                         });
                        } else {
                          setState(() {
                            gendername = "Other";
                          });
                        }
                      String respone = await register(gendername);
                      if(respone == "ok"){
                       String token = await APIRepository().login(_accountController.text, _passwordController.text);
                       User user = await APIRepository().current(token);
                       Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(user: user)));
                      } else{
                        // thông báo lỗi ở đây
                      }
                        // var favoriteName = '';
                        // if (_checkvalue_1) {
                        //   favoriteName += "Music, ";
                        // }
                        // if (_checkvalue_2) {
                        //   favoriteName += "Movie, ";
                        // }
                        // if (_checkvalue_3) {
                        //   favoriteName += "Book, ";
                        // }
                        // if (favoriteName != "") {
                          //     favoriteName = favoriteName.substring(
                          //       0, favoriteName.length - 2);
                          // // create class
                          // var objUser = User(
                          //     fullname: fullName,
                          //     email: email,
                          //     gender: gendername,
                          //     favorite: favoriteName);
                          // // navigator to detail page
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Detail(user: objUser),
                          //   ),
                          // );
                        // }
                      },
                      child: const Text('Register'),
                    ),
                  ),
                   SizedBox(
                    width: !checkRegister ? 0 : 16,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                         setState(() {
                           checkRegister = !checkRegister;
                         });
                      },
                      child: Text( !checkRegister?  'Register': 'Login'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget signUpWidget(){
    return Column(
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
               const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Confirm password",
                  icon: Icon(Icons.password),
                ),
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  icon: Icon(Icons.text_fields_rounded),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _numberIDController,
                decoration: const InputDecoration(
                  labelText: "NumberID",
                  icon: Icon(Icons.verified_user_outlined),
                ),
              ),
                  const SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                  labelText: "PhoneNumber",
                  icon: Icon(Icons.phone),
                ),
              ),
                  const SizedBox(height: 16),
              TextFormField(
                controller: _birthDayController,
                decoration: const InputDecoration(
                  labelText: "BirthDay",
                  icon: Icon(Icons.date_range),
                ),
              ),
                  const SizedBox(height: 16),
              TextFormField(
                controller: _schoolYearController,
                decoration: const InputDecoration(
                  labelText: "School Year",
                  icon: Icon(Icons.numbers),
                ),
              ),
                  const SizedBox(height: 16),
              TextFormField(
                controller: _schoolKeyController,
                decoration: const InputDecoration(
                  labelText: "School Key",
                  icon: Icon(Icons.key),
                ),
              ),
              const SizedBox(height: 16),
              const Text("What is your Gender?"),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: const Text("Male"),
                      leading: Transform.translate(
                          offset: const Offset(16, 0),
                          child: Radio(
                            value: 1,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          )),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: const Text("Female"),
                        leading: Transform.translate(
                          offset: const Offset(16, 0),
                          child: Radio(
                            value: 2,
                            groupValue: _gender,
                            onChanged: (value) {
                              setState(() {
                                _gender = value!;
                              });
                            },
                          ),
                        )),
                  ),
                  Expanded(
                      child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: const Text("Other"),
                    leading: Transform.translate(
                        offset: const Offset(16, 0),
                        child: Radio(
                          value: 3,
                          groupValue: _gender,
                          onChanged: (value) {
                            setState(() {
                              _gender = value!;
                            });
                          },
                        )),
                  )),
                ],
              ),
              const SizedBox(height: 16),
      ],
    );
  }
}
