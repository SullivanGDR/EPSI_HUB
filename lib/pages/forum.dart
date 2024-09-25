import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {

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
                      const Center(
                        child: Text(
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
                          onPressed: () {
                            // Validation des champs
                            String title = _titleController.text;
                            String message = _messageController.text;
                            if (title.isEmpty || message.isEmpty) {
                              setState(() {
                                _errorMessage =
                                'Veuillez remplir tous les champs.';
                              });
                            } else {
                              // Logique pour soumettre les données
                              print('Titre: $title');
                              print('Message: $message');
                              Navigator.pop(context); // Ferme le modal après soumission
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const Row(
                      children: [
                        Icon(CupertinoIcons.person_crop_circle),
                        SizedBox(width: 10),
                        Text(
                          'Utilisateur',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Publié le : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right),
                    const SizedBox(width: 5),
                    Text(
                      '26 réponses disponibles',
                      style: TextStyle(
                        color: Colors.grey[600], // Gris clair
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showPostModal,
        backgroundColor: Colors.white,
        child: const Icon(CupertinoIcons.chat_bubble_2),
        shape: const CircleBorder(),
      ),
    );
  }
}
