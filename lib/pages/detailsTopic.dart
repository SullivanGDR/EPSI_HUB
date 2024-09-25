import 'package:epsi_hub/class/topic_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsTopicPage extends StatefulWidget {
  final Topic topic;
  const DetailsTopicPage({super.key, required this.topic});

  @override
  State<DetailsTopicPage> createState() => _DetailsTopicPageState();
}

class _DetailsTopicPageState extends State<DetailsTopicPage> {
  bool _showResponses = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
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
                    Icon(CupertinoIcons.person_crop_circle),
                    const SizedBox(width: 10),
                    Text(
                      '${widget.topic.getUtilisateur()}',
                      style: TextStyle(
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
              style: TextStyle(fontSize: 14, color: Colors.black),
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
                  Icon(CupertinoIcons.bubble_left_bubble_right),
                  const SizedBox(width: 5),
                  Text(
                    '${widget.topic.getNbRep()} réponses disponibles',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    _showResponses
                        ? CupertinoIcons.chevron_up
                        : CupertinoIcons.chevron_down,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Column(
                children: widget.topic.getRep().map((response) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      response.getMessage(),
                      style: TextStyle(color: Colors.black),
                    ),
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
    );
  }
}
