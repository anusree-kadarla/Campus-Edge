import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor/AdminHomePage.dart';
import 'package:minor/services/auth_service.dart';
class LoginPage extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Login'),
              // onPressed: _login,
              onPressed: ()async{
                if(_usernameController.text == "" || _passwordController.text == ""){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All feilds are required !"), backgroundColor: Colors.red,));
                }
                else{
                  User? result = await AuthService().login(_usernameController.text,_passwordController.text,context);
                  if(result !=null){
                    print('Success');
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AdminHomePage()), (route) => false);
                    // print(result.email);
                }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
