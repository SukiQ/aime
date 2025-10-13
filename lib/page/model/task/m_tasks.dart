import 'package:aime/cache/db/task.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/task/m_task_detail.dart';
import 'package:aime/setting/app_routes.dart';
import 'package:aime/system/domain/navigator.dart';
import 'package:aime/system/widget/field/search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TasksPageState();
  }
}

class _TasksPageState extends State<TasksPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _queryController = TextEditingController();
  late TaskDao _dao;
  List<Task> _tasks = [];
  List<Task> _search = [];

  @override
  void initState() {
    super.initState();
    _queryController.addListener(() {
      setState(() {});
    });
    _load();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final _ = ScreenHelper.isWide(context);
    _search = _tasks
        .where(
          (task) => task.name!.toLowerCase().contains(
            _queryController.text.toLowerCase(),
          ),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.task),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.calendarPlus200),
            tooltip: l10n.modelAddLabel,
            onPressed: () async {
              _onNavigate(
                await Navigator.pushNamed(context, AppRoutes.mTasksAdd),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchTextField(controller: _queryController),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Divider(
                    indent: 7,
                    endIndent: 7,
                    color: Theme.of(context).colorScheme.scrim,
                    thickness: 0.5,
                    height: 1,
                  );
                },

                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: _search.length,
                itemBuilder: (context, index) {
                  return buildTaskTile(index, _search[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _load() async {
    TaskDao.build(context)
        .then((dao) {
          _dao = dao;
          return _dao.all();
        })
        .then((tasks) {
          setState(() {
            _tasks = tasks;
          });
        });
  }

  Widget buildTaskTile(int index, Task task) {
    return Dismissible(
      key: Key(task.id!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _dao.delete(task.id!);
        setState(() {
          _tasks.removeAt(index);
        });
      },
      child: ListTile(
        minTileHeight: 60,
        leading: Icon(LucideIcons.scrollText300),
        title: Text(task.name!),
        onTap: () async {
          _onNavigate(
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailPage(id: task.id!),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onNavigate(Object? result) {
    if (result == null) {
      return;
    }
    final navigatorResult = result as NavigatorResult;
    switch (navigatorResult.operation) {
      case NavigatorOperation.none:
        return;
      case NavigatorOperation.remove:
        setState(() {
          final task = navigatorResult.result as Task;
          _tasks.removeWhere((element) => element.id == task.id);
        });
        return;
      case NavigatorOperation.update:
        setState(() {
          final task = navigatorResult.result as Task;
          _tasks[_tasks.indexWhere((element) => element.id == task.id)] = task;
        });
        return;
      case NavigatorOperation.add:
        final task = navigatorResult.result as Task;
        _tasks.add(task);
        return;
    }
  }
}
