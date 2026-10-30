
import "package:flutter/material.dart";
import "package:food_delivery_app/Components/background_color.dart";
import "package:food_delivery_app/Components/buttons.dart";
import "package:food_delivery_app/Components/text_feilds.dart";
import "package:food_delivery_app/Models/user_model.dart";
import "package:food_delivery_app/Providers/auth_provider.dart";
import "package:food_delivery_app/Screens/login_screen.dart";
import "package:provider/provider.dart";

class SignUpScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

    final  _signupKey = GlobalKey<FormState>();
   final fullNameController = TextEditingController();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final  confrimPasswordController = TextEditingController();

   bool obscureText = true;

   void togglePasswordVisibility(){
    setState(() {
      obscureText = !obscureText;
    });
   }


// SUBMIT FUNCTION 

   void submit() async{

    if(_signupKey.currentState!.validate()){

      (_signupKey.currentState?.save());

      final addedUser = UserModel(
        fullName: fullNameController.text.trim(), 
        email: emailController.text.trim(), 
        password: passwordController.text.trim());

    try{
      await Provider.of<AuthProvider>(context,
     listen: false).addUser (addedUser);

    if(!context.mounted) return;

     ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account created successfully!, SignIn'),
        backgroundColor: Colors.green,
      ),);

    _signupKey.currentState!.reset();
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confrimPasswordController.clear();


    }catch (error){
      if(!context.mounted) return;

       ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:Text('Faield ${error.toString}'),
        backgroundColor: Colors.red,
      ),);

    }
  



    }

   }

   //BODY!!!!

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(
        key: _signupKey,
        child: BackgroundColor(
          
            child:SingleChildScrollView(
         //FORM AREA
            child:  Column(
                children: [
                      
                  const SizedBox(height: 30,),
                  Image.asset('lib/images/banner.png',width: 250,height: 200,),
                  
                      
                  Container(
                        width: double.infinity,
                        height: 1000,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                          color: Colors.grey.shade300),
                      child: Column(
                        children: [
                          const SizedBox(height: 10,),
                           Column(
                             children: [
                               Text('Create an account and enjoy', 
                                             style: TextStyle(fontSize: 16, color: Colors.black),),
                               Text('delicious meals, deliverd to you.', 
                                             style: TextStyle(fontSize: 16, color: Colors.black),),
                          const SizedBox(height: 10,),
        
             // NAME FORMFIELD
                     
              MyTextFeilds(prefixIcon: Icon(Icons.person_outline), hintText: 'Full Name', 
              controller: fullNameController,
               validator: (value) { 
                if(value == null || value.isEmpty){
                  return 'Name is Required';
                }else{
                  return null;
                }}, 
                onSaved: (value) { 
                  fullNameController.text = value!;
                 }, obscureText: false,),
        
            // EMAIL FORMFIELD
        
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
                

                }, 
                onSaved: (value) { emailController.text = value!; }, 
                obscureText: false,),
        
            // PASSWORD FORMFIELD
        
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
        
            // CONFIRMPASSWORD FORMFIELD      
        
              MyTextFeilds(keyboardType: TextInputType.numberWithOptions(),
                prefixIcon: Icon(Icons.lock_outline), hintText: 'Confirm Password', 
              suffixIcon: IconButton(onPressed: () { togglePasswordVisibility(); }, 
              icon: Icon(
                obscureText
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined
              )), 
              
              controller:  confrimPasswordController,
              validator: (value) {  
        
                if(value == null || value.isEmpty){
                  return 'Confirm password';
                }
        
                if(value != passwordController.text){
                  return 'Password mismatch';
                }else{
                  return null;
                }}, onSaved: (value) { confrimPasswordController.text = value!; }, 
                obscureText: obscureText, ),
        
        // THE SIGN UP BUTTON
                          
                           const SizedBox(height: 25),
                      
                           Buttons(onTap: submit, buttonText: 'SIGN UP'),
                      
                           const SizedBox(height: 25),
        
        // LOG IN IF YOU ALREADY HAVE AN ACCOUNT
                    
                            Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      
                      Expanded(
                        child: Divider(
                          indent: 15, endIndent: 15,
                          color:   Color(0XFF603923)
                        ),
                      ),
                      
                       Text('Already have an account?', 
                        style: TextStyle(fontSize: 14, color: Colors.black),),
                        
                        SizedBox(width: 6,),
        
          // LOGIN GESTURE DETECTOR
           
                       GestureDetector(
                        onTap: () {
                         Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => LoginScreen() ));
                        },
                         child: Text('Login', 
                          style: TextStyle(fontSize: 16, fontWeight: .bold, color: Color(0xFFB87945),),),
                       ),
                      
                       Expanded(child: Divider(
                        indent: 15, endIndent: 15,
                        color:   Color(0XFF603923)
                       ))
              
                     ],
                   ),
                      
                             ],
                           ),
                        ],
                      ),
                      ),
                      
                  
                  
                ],),
            ),
           ),
       ),
    );
  }
}