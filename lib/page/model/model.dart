import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:cbl/cbl.dart';
import 'package:cbl_flutter/cbl_flutter.dart';

import '../../config/style_config.dart';

class ModelPage extends StatelessWidget {
  const ModelPage({super.key});


  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(LucideIcons.codesandbox200,size: 80,color: AppColors.seedColor,));
  }
}

// class NotesPage extends StatefulWidget {
//   const NotesPage({super.key});
//
//   @override
//   State<NotesPage> createState() => _NotesPageState();
// }
//
// class _NotesPageState extends State<NotesPage> {
//   late Database _db;
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, Object?>> _notes = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _initDb();
//   }
//
//   Future<void> _initDb() async {
//     _db = await Database.openAsync('notes_db');
//     await _loadNotes();
//   }
//
//   Future<void> _loadNotes() async {
//     final query = const QueryBuilder()
//         .select(SelectResult.all())
//         .from(DataSource.database('notes_db' as Database));
//
//     final result = await (await query.execute()).allResults();
//
//     setState(() {
//       _notes = result
//           .map((row) => row.toPlainMap()['notes_db'] as Map<String, Object?>)
//           .toList();
//     });
//   }
//
//   Future<void> _addNote() async {
//     if (_controller.text.isEmpty) return;
//
//     final doc = MutableDocument({
//       'text': _controller.text,
//       'createdAt': DateTime.now().toIso8601String(),
//     });
//
//     await _db.saveDocument(doc);
//     _controller.clear();
//     await _loadNotes();
//   }
//
//   Future<void> _deleteNote(String id) async {
//     final doc = await _db.document(id);
//     if (doc != null) {
//       await _db.deleteDocument(doc);
//       await _loadNotes();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Notes')),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: '输入笔记内容',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.add),
//                   onPressed: _addNote,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _notes.length,
//               itemBuilder: (context, index) {
//                 final note = _notes[index];
//                 return ListTile(
//                   title: Text(note['text'] as String? ?? ''),
//                   subtitle: Text(note['createdAt'] as String? ?? ''),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () async {
//                       final query = await _db.createQuery(
//                         'SELECT META().id FROM _ WHERE text = \$text',
//                       );
//                       final rs = await query.execute(
//                         parameters: {'text': note['text']},
//                       );
//                       final id = rs.allResults().first.string('id');
//                       if (id != null) {
//                         await _deleteNote(id);
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }