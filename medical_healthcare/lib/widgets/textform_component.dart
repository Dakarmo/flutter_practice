
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_heathcare/utils/utils.dart';

class TextForm extends StatefulWidget {
  TextEditingController controller;
  String labelText;
  IconData icon;
  bool isObscureText;
  TextInputType inputType;

  TextForm({required this.controller, required this.labelText,required this.icon, this.isObscureText = false, this.inputType = TextInputType.text });

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.icon != Icons.lock ? !passToggle : passToggle,
            keyboardType: widget.inputType,

            validator: (value) {
              print(widget.labelText );
              if(value == null || value.isEmpty) {
                return 'Veuillez entrer un ${widget.labelText}';
              }
              if(widget.labelText == "Adresse e-mail" && !validateEmail(value)){

                return "Veuillez entrer un Email valide";
              }
              if(widget.labelText == "Numéro de téléphone" && !validatePhoneNumber(value)) {
                return "- Le numéro doit commencer par un + \n - Suivi de 1 à 3 chiffre pour le code pays\n - Puis de 4 groupes de 2 chiffres\n - Au total 8 chiffres après le code pays.";
              }
              return null;
            },
            onSaved: (val) => widget.controller.text = val!,
            decoration: InputDecoration(
              hintText: widget.labelText,
              labelText: widget.labelText,
              border: OutlineInputBorder(),
              prefixIcon: Icon(widget.icon),
              suffixIcon: widget.icon == Icons.lock ? InkWell(
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
                ) : null,

            ),

      ),
    );
  }
}
