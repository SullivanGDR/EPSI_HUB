import 'package:epsi_hub/fonctions/register_API.dart';
import 'package:epsi_hub/pages/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextEditingController _passwordController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _nomController = TextEditingController();
TextEditingController _prenomController = TextEditingController();
TextEditingController _campusController = TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Future<bool> inscription(
      email, mdp, nom, prenom, campus) async {
    var rep = await register(email, mdp, nom, prenom,campus);
    return rep;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Center(
              child: Text(
                'Inscrivez-vous',
                style: TextStyle(color: Colors.black, fontSize: 50),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween,
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nom'),
                  ),
                ),
                const SizedBox(
                    width: 10),
                Expanded(
                  child: TextField(
                    controller: _prenomController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Prenom'),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Mot de passe'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 15),
              child: TextField(
                controller: _campusController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Campus'),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const Text("(*) : Champs non obligatoires."),
            const Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: 50,
              width: 250,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () async {
                  String password = _passwordController.text;
                  String email = _emailController.text;
                  String nom = _nomController.text;
                  String prenom = _prenomController.text;
                  String campus = _campusController.text;
                  var rep = await inscription(
                      email, password, nom, prenom,campus);
                  if (rep == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Compte créé avec succès')),
                    );
                    Navigator.popAndPushNamed(context, '/login');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                          Text('Erreur lors de la création du compte')),
                    );
                  }
                },
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 60),
              child: Divider(),
            ),
            const Padding(padding: EdgeInsets.only(top: 15)),
            Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: const Text(
                      'Se connecter ?',
                      style: TextStyle(
                        color: Colors.black,
                        decoration:
                        TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}