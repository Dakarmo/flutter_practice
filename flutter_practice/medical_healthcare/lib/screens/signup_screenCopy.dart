import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_heathcare/screens/login_screen.dart';
import 'package:medical_heathcare/services/service.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Créer un objet du service
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Image.asset("images/doctor4.jpg")
                ),
                SizedBox(height: 5,),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Nom Complet",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Adresse mail",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: TextField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: "Numéro de téléphone",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    )
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: TextField(
                      controller: passwordController,
                      obscureText: passToggle ? true : false ,
                      decoration: InputDecoration(
                        labelText: "Mot de passe",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                          onTap: (){
                            if(passToggle == true) {
                              passToggle = false;
                            }else {
                              passToggle = true;
                            }
                            setState(() {

                            });
                          },
                          child: passToggle ? Icon(CupertinoIcons.eye_slash_fill) : Icon(CupertinoIcons.eye_fill),
                        )
                      ),
                    ),
                ),
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
                          onTap: () {
                            // Navigator.push(context, MaterialPageRoute(
                            //   builder: (context) => LoginScreen(),
                            // ));
                            //
                            service.saveUser(
                                nameController.text,
                                emailController.text,
                                mobileController.text,
                                passwordController.text
                            );


                          },
                          child: Padding(
                              padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                              child: Center(
                                child: Text(
                                  "Create Account",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous avez déjà un compte ?",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black54
                      ),
                    ),
                    TextButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        },
                        child: Text(
                          "Log In",
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
    );
  }
}
