import 'package:dynamic_multi_step_form/dynamic_multi_step_form.dart';
import 'package:flutter/material.dart';

class SignalerPage extends StatefulWidget {
  const SignalerPage({super.key});

  @override
  State<SignalerPage> createState() => _SignalerPageState();
}

class _SignalerPageState extends State<SignalerPage> {
  int _currentStep = 0;
  String _reportType = '';
  String _urgency = '';
  final TextEditingController _reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                onStepContinue: () {
                  if (_currentStep < 2) {
                    setState(() {
                      _currentStep++;
                    });
                  } else {
                    // Logique après soumission
                    print('Type de signalement: $_reportType');
                    print('Raison: ${_reasonController.text}');
                    print('Urgence: $_urgency');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signalement soumis avec succès !')),
                    );
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
                    title: Text('Type de signalement'),
                    content: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Sélectionner le type de signalement',
                      ),
                      items: [

                        DropdownMenuItem(child: Text('Problèmes techniques'), value: 'tech'),
                        DropdownMenuItem(child: Text('Problèmes pédagogiques'), value: 'peda'),
                        DropdownMenuItem(child: Text('Problèmes administratifs'), value: 'admin'),
                        DropdownMenuItem(child: Text('Suggestions d\'améliorations'), value: 'amelio'),
                        DropdownMenuItem(child: Text('Comportements inapropriés'), value: 'comportements'),
                        DropdownMenuItem(child: Text('Problèmes infrastructures'), value: 'infra'),
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
                    title: Text('Raison du signalement'),
                    content: TextField(
                      controller: _reasonController,
                      decoration: InputDecoration(
                        labelText: 'Décrire la raison',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    isActive: _currentStep >= 1,
                  ),
                  Step(
                    title: Text('Urgence'),
                    content: Column(
                      children: [
                        RadioListTile<String>(
                          title: Text('Faible'),
                          value: 'Faible',
                          groupValue: _urgency,
                          onChanged: (value) {
                            setState(() {
                              _urgency = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Moyenne'),
                          value: 'Moyenne',
                          groupValue: _urgency,
                          onChanged: (value) {
                            setState(() {
                              _urgency = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Élevée'),
                          value: 'Élevée',
                          groupValue: _urgency,
                          onChanged: (value) {
                            setState(() {
                              _urgency = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 2,
                  ),
                ],
                controlsBuilder: (BuildContext context, ControlsDetails details) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: details.onStepContinue,
                        child: Text(_currentStep == 2 ? 'Soumettre' : 'Suivant'), // Texte personnalisé
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
