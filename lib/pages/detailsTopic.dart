import 'dart:convert';
import 'package:epsi_hub/class/topicReponse_class.dart';
import 'package:epsi_hub/class/topic_class.dart';
import 'package:epsi_hub/class/user_class.dart';
import 'package:epsi_hub/fonctions/topic_API.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

class DetailsTopicPage extends StatefulWidget {
  final Topic topic;
  const DetailsTopicPage({super.key, required this.topic});

  @override
  State<DetailsTopicPage> createState() => _DetailsTopicPageState();
}

class _DetailsTopicPageState extends State<DetailsTopicPage> {
  bool _showResponses = false;
  final TextEditingController _messageController = TextEditingController();
  bool _isLoading = true;
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  User user = User(0, "_email","role", "_token", "_prenom", "_nom", "_campus");
  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
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
          : _buildContent(context),
    );
  }

  Widget _buildContent(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(CupertinoIcons.person_crop_circle),
                          const SizedBox(width: 10),
                          Text(
                            widget.topic.getUtilisateur(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Publié le : ${DateFormat('dd/MM/yyyy').format(widget.topic.getDate())}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.topic.getDescription(),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _showResponses = !_showResponses;
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(CupertinoIcons.bubble_left_bubble_right),
                        const SizedBox(width: 5),
                        Text(
                          '${widget.topic.getNbRep()} réponses disponibles',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          _showResponses
                              ? CupertinoIcons.chevron_down
                              : CupertinoIcons.chevron_up,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Column(
                      children: widget.topic.getRep().map((response) {
                        return ListTile(
                          leading: const Icon(CupertinoIcons.person_crop_circle),
                          title: Text(response.getUtilisateur()),
                          subtitle: Text(response.getMessage()),
                        );
                      }).toList(),
                    ),
                    crossFadeState: _showResponses
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white, // Fond principal de la Row
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Fond transparent pour le TextField
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)), // Bordure légère
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: "Écrire un message...",
                          border: InputBorder.none,
                          filled: false,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // Espacement interne
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black, // Fond noir pour le bouton
                      borderRadius: BorderRadius.circular(8), // Arrondir les bords du bouton
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white), // Icône blanche
                      onPressed: () async {
                        if (_messageController.text.isNotEmpty) {
                          bool rep = await addTopicR(widget.topic.getId(), _messageController.text, user.getId());
                          TopicR(_messageController.text, DateTime.now(), user.getId().toString());

                          if (rep == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Réponse soumise avec succès!')),
                            );
                            Navigator.popAndPushNamed(context, '/forum');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Erreur lors de l'envoi de la réponse!")),
                            );
                          }
                          _messageController.clear();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
