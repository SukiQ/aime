import 'package:aime/cache/db/task.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/domain/navigator.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TaskAddPage extends StatefulWidget {
  const TaskAddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskAddPageState();
  }
}

class _TaskAddPageState extends State<TaskAddPage> {
  late TaskDao _dao;
  final TaskDetails _task = TaskDetails();
  final _formKey = GlobalKey<FormState>();
  late final List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (var item in _items) {
      if (item is ChangeNotifier) {
        (item as ChangeNotifier).dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    _items = buildTaskAddItems(context: context, task: _task);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.addUser),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.check300),
            tooltip: l10n.modelAddLabel,
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              _dao.add(_task);
              Navigator.pop(context, NavigatorResult(operation: NavigatorOperation.add, result: _task));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(key: _formKey, child: _buildTaskTile()),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskTile() {
    return ListView(
      children: _items.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: item,
        );
      }).toList(),
    );
  }

  Future<void> _load() async {
    _dao = await TaskDao.build(context);
  }
}

List<Widget> buildTaskAddItems({
  required BuildContext context,
  required TaskDetails task,
}) {
  final l10n = AppLocalizations.of(context)!;

  return [
    TextFormField(
      controller: TextEditingController(text: task.name),
      decoration: InputDecoration(labelText: l10n.taskName),
      validator: (value) {
        if (StringHelper.isBlank(value)) {
          return l10n.taskNameRequired;
        }
        return null;
      },
      onSaved: (value) => task.name = value,
    ),
    TextFormField(
      controller: TextEditingController(text: task.progress?.toString()),
      decoration: InputDecoration(labelText: l10n.taskProgress),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (StringHelper.isBlank(value)) {
          return null;
        }
      },
      onSaved: (value) {
        if (StringHelper.isNotBlank(value)) {
          task.progress = double.parse(value!);
        }
      },
    )
  ];
}
