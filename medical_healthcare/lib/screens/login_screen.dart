
import 'package:flutter/material.dart';
import 'package:medical_heathcare/screens/home_screen.dart';
import 'package:medical_heathcare/screens/signup_screen.dart';
import 'package:medical_heathcare/screens/welcome_screen.dart';
import 'package:medical_heathcare/services/service.dart';
import 'package:medical_heathcare/utils/utils.dart';
import 'package:medical_heathcare/widgets/navbar_roots.dart';
import 'package:medical_heathcare/widgets/textform_component.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
bool passToggle = true;

//Créer un objet du service
Service service = Service();

final emailController = TextEditingController();
final passwordController = TextEditingController();

login() async{
  String uEmail = emailController.text;
  String uPassword= passwordController.text;

  if(uEmail.isEmpty) {
    alertDialog(context, "Veuillez entrer votre Adresse e-mail");
  }else if(uPassword.isEmpty){
    alertDialog(context, "Veuillez entrer votre Mot de passe");
  }else {
    await service.loginUser(uEmail, hashPassword(uPassword)).then((response){
      if(response['status'] == "error"){
        alertDialog(context, "Identifiants Incorrect");
      }else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => NavbarRoots()),
              (Route<dynamic> route) => false,
        );
      }
    });


   // print(response);


  }
}

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 5),
          Align(alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed:  (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => WelcomeScreen(),
                    ));
                  },
                  child: Text(
                      'SKIP',
                      style: TextStyle(
                        color: Color(0xFF7165D6),
                        fontSize:16,
                      )
                  )
              )
          ),
          // SizedBox(height: 10),
          SingleChildScrollView(
            child: SafeArea(
                child: Column(
                  children: [
                    // SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Image.asset('images/doctor4.jpg'),
                    ),
                    SizedBox(height: 5),
                    // Padding(
                    //     padding: EdgeInsets.all(12),
                    //     child:TextField(
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           label: Text('Entrer votre Nom d\'utilisateur'),
                    //           prefixIcon: Icon(Icons.person),
                    //         )
                    //     )
                    // ),
                    TextForm(controller: emailController, labelText: 'Adresse e-mail', icon: Icons.email),

                    TextForm(controller: passwordController, labelText: 'Mot de passe', icon: Icons.lock),
                    // Padding(
                    //     padding: EdgeInsets.all(12),
                    //     child:TextField(
                    //       obscureText: passToggle ? false : true,
                    //         decoration: InputDecoration(
                    //           border: OutlineInputBorder(),
                    //           label: Text('Entrer votre Mot de passe'),
                    //           prefixIcon: Icon(Icons.lock),
                    //           suffixIcon: InkWell(
                    //             onTap: () {
                    //               if(passToggle == true) {
                    //                 passToggle = false;
                    //               }else {
                    //                 passToggle = true;
                    //               }
                    //               setState(() {
                    //
                    //               });
                    //             },
                    //             child: passToggle ? Icon(CupertinoIcons.eye_slash_fill) : Icon(CupertinoIcons.eye_fill),
                    //           )
                    //         )
                    //     )
                    // ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity,
                        child: Material(
                          color:Color(0xFF7165D6),
                          borderRadius: BorderRadius.circular(10),
                          // key: ,
                          child: InkWell(
                              onTap: login,
                              child: Padding(
                                  padding:
                                  EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                  child: Center(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                              )
                          ),

                        ),
                      ),
                    ),
                    // SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Vous n'avez pas un compte ?",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black54
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                            },
                            child: Text(
                              "Créer un Compte",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFF7165D6)
                              ),

                            )
                        )

                      ],
                    )
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}
