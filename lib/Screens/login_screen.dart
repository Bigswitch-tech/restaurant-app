import 'package:flutter/material.dart';
import 'package:food_delivery_app/Components/background_color.dart';
import 'package:food_delivery_app/Components/buttons.dart';
import 'package:food_delivery_app/Components/text_feilds.dart';
import 'package:food_delivery_app/Models/user_model.dart';
import 'package:food_delivery_app/Providers/auth_provider.dart';
import 'package:food_delivery_app/Screens/home_screen.dart';
import 'package:food_delivery_app/Screens/sign_up_screen.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _loginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscureText = true;

  void togglePasswordVisibility(){
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body:Form(
        key: _loginKey,
        child: BackgroundColor(
        child: SingleChildScrollView(
            child: Column(
              children: [
            
                const SizedBox(height: 50),
            
                  Container(
                    height: 300, width: 300,
                    child: Image.asset('lib/images/banner.png', fit: BoxFit.contain,)),
            
                   const SizedBox(height: 20),
            
                  
                     Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top:Radius.circular(50)),
                          color: Colors.grey.shade300,
                      ),
                      
                      width: double.infinity,
                      child: Column(
                        children: [
                  const SizedBox(height: 20),
            
                  Text('Already a member ?', 
                  style: TextStyle(fontSize: 16, color: Colors.black),),
            
                  const SizedBox(height: 10),
        
            //EMAIL FORM
                  MyTextFeilds(prefixIcon: Icon(Icons.email_outlined), hintText: 'Email', 
              controller: emailController, 
              validator: (value) { 
                if(value == null || value.isEmpty){
                  return 'Email is Required';
                }
                
                      final emailRegex = RegExp(
                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                      );
                                          
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enetr a valid email';
                    } else{
                  return null;
                } 
               }, obscureText: false,   
               onSaved: (value) { emailController.text = value!; },       
                ),
        
            //PASSWORD FORM
                  MyTextFeilds(
                keyboardType: TextInputType.numberWithOptions(),
                prefixIcon: Icon(Icons.lock_outline), hintText: 'Password', 
              suffixIcon: IconButton(onPressed: (){
                 togglePasswordVisibility();},
            icon: Icon(

              obscureText
             
              ? Icons.visibility_off
              : Icons.visibility_outlined
            )), 
              
              controller: passwordController, 
              validator: (value) { 
                if(value == null || value.isEmpty){
                  return 'Password Required';
                }
                if (value.length > 6){
                  return 'Input 6 digits only';
                }
                else{
                  return null;
                } }, 
                onSaved: (value) { 
                  passwordController.text = value!; }, 
                obscureText: obscureText,),
            
            //DONT HAVE AN ACCOUNT SECTION
        
                   SizedBox(height: 15),
            
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Don\'t have an account?', 
                      style: TextStyle(fontSize: 14, color: Colors.black),),
                      
                      SizedBox(width: 6,),
                      
                     GestureDetector(
                      onTap: () {
                       Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(), ));
                      },
                       child: Text('Sign Up', 
                        style: TextStyle(fontSize: 16, fontWeight: .bold, color: Color(0xFFB87945)),),
                     ),
            
                   ],
                 ),
            
                  SizedBox(height: 50),
        
            //LOGIN BUTTON
            
                Buttons(onTap:() async {
                      if (_loginKey.currentState!.validate()) {
                        final user = UserModel(
                          fullName: '',
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
        
                        final success = await context.read <AuthProvider>().loginUser(user);
        
                        if (success) {
                          Navigator.push(context,
                           MaterialPageRoute(builder: ((context) => HomePageScreen())));
                        } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Failed'),
                                    backgroundColor: Colors.red ));
                        
                        }
                      }
                    },
                
                 buttonText: 'LOGIN',),
                   
            
                SizedBox(height: 200),
            
                        ],
                      ),
                    ),
                  
            
              ],
            ),
          ),
        ),
      )
    );
  }
}