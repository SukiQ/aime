import 'package:flutter/material.dart';

/// 一个可复用的搜索框组件
class CustomSearchBar<T> extends StatefulWidget {
  /// 数据源
  final List<T> items;

  /// 过滤条件（必须传，决定如何过滤）
  final bool Function(T item, String query) filter;

  /// 构建显示的列表项
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// 占位提示文本
  final String hintText;

  const CustomSearchBar({
    super.key,
    required this.items,
    required this.filter,
    required this.itemBuilder,
    this.hintText = '搜索',
  });

  @override
  State<CustomSearchBar<T>> createState() => _CustomSearchBarState<T>();
}

class _CustomSearchBarState<T> extends State<CustomSearchBar<T>> {
  final TextEditingController _controller = TextEditingController();
  late List<T> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = List.from(widget.items);
  }

  void _onQueryChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        _filtered = List.from(widget.items);
      } else {
        _filtered = widget.items.where((e) => widget.filter(e, query)).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(
          controller: _controller,
          hintText: widget.hintText,
          leading: const Icon(Icons.search),
          trailing: [
            if (_controller.text.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  _onQueryChanged('');
                },
              ),
          ],
          onChanged: _onQueryChanged,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: _filtered.isEmpty
              ? const Center(child: Text('没有匹配结果'))
              : ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) =>
                widget.itemBuilder(context, _filtered[index]),
          ),
        ),
      ],
    );
  }
}
