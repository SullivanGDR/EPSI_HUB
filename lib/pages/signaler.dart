import 'dart:convert';

import 'package:epsi_hub/class/user_class.dart';
import 'package:epsi_hub/fonctions/login_api.dart';
import 'package:epsi_hub/fonctions/signalement_API.dart';  // Import du signalement API
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

class SignalerPage extends StatefulWidget {
  const SignalerPage({super.key});

  @override
  State<SignalerPage> createState() => _SignalerPageState();
}

class _SignalerPageState extends State<SignalerPage> {
  int _currentStep = 0;
  String _reportType = '';
  final TextEditingController _reasonController = TextEditingController();
  bool _isLoading = true;
  bool _isLog = false;
  User user = User(0, "_email","role", "_token", "_prenom", "_nom", "_campus");
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      print(user.getCampus());
      _isLog = await isLogin(user.getToken(), user.getId());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          :  _buildContent(),
    );
  }

  @override
  Widget _buildContent() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                const Text(
                  'Faire un signalement',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Stepper(
                  currentStep: _currentStep,
                  onStepContinue: () async {
                    // Vérification de la progression du stepper
                    if (_currentStep < 1) {
                      setState(() {
                        _currentStep++;
                      });
                    } else {
                      // Logique après soumission avec appel à l'API signalement
                      bool rep = await addSignalement(
                          _reportType, _reasonController.text, user.getId());
                      if (rep == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Signalement soumis avec succès !')),
                        );
                        Navigator.popAndPushNamed(context, '/signalements');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Erreur lors du signalement')),
                        );
                      }
                    }
                  },
                  onStepCancel: () {
                    if (_currentStep > 0) {
                      setState(() {
                        _currentStep--;
                      });
                    }
                  },
                  steps: [
                    Step(
                      title: const Text('Type de signalement'),
                      content: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Sélectionner le type de signalement',
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Problèmes techniques', child: Text('Problèmes techniques')),
                          DropdownMenuItem(value: 'Problèmes pédagogiques', child: Text('Problèmes pédagogiques')),
                          DropdownMenuItem(value: 'Problèmes administratifs', child: Text('Problèmes administratifs')),
                          DropdownMenuItem(value: 'Suggestions d\'améliorations', child: Text('Suggestions d\'améliorations')),
                          DropdownMenuItem(value: 'Comportements inapropriés', child: Text('Comportements inapropriés')),
                          DropdownMenuItem(value: 'Problèmes infrastructures', child: Text('Problèmes infrastructures')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _reportType = value!;
                          });
                        },
                      ),
                      isActive: _currentStep >= 0,
                    ),
                    Step(
                      title: const Text('Raison du signalement'),
                      content: TextField(
                        controller: _reasonController,
                        decoration: const InputDecoration(
                          labelText: 'Décrire la raison',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      isActive: _currentStep >= 1,
                    ),
                  ],
                  controlsBuilder: (BuildContext context, ControlsDetails details) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            // Vérification si nous sommes à la fin du stepper
                            if (_currentStep == 1) {
                              bool rep = await addSignalement(
                                  _reportType, _reasonController.text, user.getId());
                              if (rep == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Signalement soumis avec succès !')),
                                );
                                Navigator.popAndPushNamed(context, '/signalements');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Erreur lors du signalement')),
                                );
                              }
                            } else {
                              details.onStepContinue!();
                            }
                          },
                          child: Text(_currentStep == 1 ? 'Soumettre' : 'Suivant'), // Texte personnalisé
                        ),
                        const SizedBox(width: 8),
                        if (_currentStep > 0) // Afficher "Précédent" seulement après la première étape
                          TextButton(
                            onPressed: details.onStepCancel,
                            child: const Text('Précédent'), // Texte personnalisé
                          ),
                      ],
                    );
                  },
                ),
              ],
            )
          ],
        )
    );
  }
}
