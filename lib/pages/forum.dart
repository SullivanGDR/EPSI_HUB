import 'dart:convert';

import 'package:epsi_hub/class/topic_class.dart';
import 'package:epsi_hub/class/user_class.dart';
import 'package:epsi_hub/fonctions/topic_api.dart';
import 'package:epsi_hub/pages/detailsTopic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<Topic> _listeTopic = [];
  bool _isLoading = true;
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  User user = User(0, "_email","role", "_token", "_prenom", "_nom", "_campus");
  void _showPostModal() {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _messageController = TextEditingController();
    String _errorMessage = '';

    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 400,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: const Text(
                          'Rédiger un nouveau post',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Titre',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          keyboardType: TextInputType.multiline,
                          expands: true,
                        ),
                      ),
                      if (_errorMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorMessage,
                            style: const TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                          onPressed: () async{
                            String title = _titleController.text;
                            String message = _messageController.text;
                            if (title.isEmpty || message.isEmpty) {
                              setState(() {
                                _errorMessage =
                                'Veuillez remplir tous les champs.';
                              });
                            } else {
                              await addTopic(title, message, user.getId());
                              print('Titre: $title');
                              print('Message: $message');
                              Navigator.popAndPushNamed(context,'/forum');// Ferme le modal après soumission
                            }
                          },
                          child: const Text('Publier'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _listeTopic = await initListTopic(_listeTopic);
    print(_listeTopic);
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
          : _buildContent(),
    );
  }

  @override
  Widget _buildContent() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230),
      ),
      body: Expanded(
        child: ListView.builder(itemCount : _listeTopic.length
            ,itemBuilder: (context,index){
          final topic = _listeTopic[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsTopicPage(topic: topic),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(color: Colors.black, width: 1.0)
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.person_crop_circle),
                          const SizedBox(width: 10),
                          Text(
                            '${topic.getUtilisateur()}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Publié le : ${DateFormat('dd/MM/yyyy').format(topic.getDate())}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600], // Gris clair
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    topic.getDescription(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(CupertinoIcons.bubble_left_bubble_right),
                      const SizedBox(width: 5),
                      Text(
                        '${topic.getNbRep()} réponses disponibles',
                        style: TextStyle(
                          color: Colors.grey[600], // Gris clair
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostModal,
        backgroundColor: Colors.white,
        child: Icon(CupertinoIcons.chat_bubble_2),
        shape: CircleBorder(),
      ),
    );
  }
}
