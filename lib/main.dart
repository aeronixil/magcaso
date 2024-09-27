import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

@immutable
class Lesson {
  const Lesson({
    required this.id,
    required this.title,
    required this.topic,
    required this.summary,
    required this.body,
    required this.exercise,
  });

  final String id;
  final String title;
  final String topic;
  final String summary;
  final String body;
  final String exercise;

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    id: json['id'] as String,
    title: json['title'] as String,
    topic: json['topic'] as String,
    summary: json['summary'] as String,
    body: json['body'] as String,
    exercise: json['exercise'] as String,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.initialLessons});

  /// Supplying lessons skips asset loading, which keeps previews and tests deterministic.
  final List<Lesson>? initialLessons;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() => setState(() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
  });

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF5267D8);
    return MaterialApp(
      title: 'Magcaso',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomePage(
        initialLessons: widget.initialLessons,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.initialLessons, required this.onToggleTheme});

  final List<Lesson>? initialLessons;
  final VoidCallback onToggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Lesson>> _lessonsFuture;
  final Set<String> _favorites = {};
  String _query = '';
  String _topic = 'All topics';
  bool _favoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _lessonsFuture = widget.initialLessons != null
        ? Future.value(List.unmodifiable(widget.initialLessons!))
        : _loadLessons();
  }

  void _retryLoading() => setState(() => _lessonsFuture = _loadLessons());

  Future<List<Lesson>> _loadLessons() async {
    final decoded = jsonDecode(
      await rootBundle.loadString('assets/lessons/index.json'),
    );
    if (decoded is! List) {
      throw const FormatException('Lesson index must be a JSON array.');
    }
    return decoded
        .map((item) {
          if (item is! Map<String, dynamic>) {
            throw const FormatException('Each lesson must be an object.');
          }
          return Lesson.fromJson(item);
        })
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: FutureBuilder<List<Lesson>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _message(
              Icons.cloud_off_outlined,
              'Lessons couldn’t load',
              'Check your connection or lesson index, then try again.',
              actionLabel: 'Try again',
              onAction: _retryLoading,
            );
          }
          final lessons = snapshot.data ?? const <Lesson>[];
          if (lessons.isEmpty) {
            return _message(
              Icons.auto_stories_outlined,
              'Your classroom is ready',
              'Lessons will appear here once they are added.',
            );
          }
          final topics = lessons.map((lesson) => lesson.topic).toSet().toList()
            ..sort();
          topics.insert(0, 'All topics');
          final filtered = lessons.where((lesson) {
            final q = _query.trim().toLowerCase();
            final matchesQuery =
                q.isEmpty ||
                '${lesson.title} ${lesson.topic} ${lesson.summary}'
                    .toLowerCase()
                    .contains(q);
            return matchesQuery &&
                (_topic == 'All topics' || lesson.topic == _topic) &&
                (!_favoritesOnly || _favorites.contains(lesson.id));
          }).toList();

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                title: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: Icon(
                        Icons.auto_stories_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Flexible(
                      child: Text(
                        'magcaso',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    tooltip: _favoritesOnly
                        ? 'Show all lessons'
                        : 'Show favorites',
                    onPressed: () =>
                        setState(() => _favoritesOnly = !_favoritesOnly),
                    icon: Icon(
                      _favoritesOnly ? Icons.favorite : Icons.favorite_border,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Toggle appearance',
                    onPressed: widget.onToggleTheme,
                    icon: const Icon(Icons.brightness_6_outlined),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      'YOUR LEARNING SPACE',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Small lessons.\nBig progress.',
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            height: 1.08,
                            letterSpacing: -1.1,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Pick up a new idea and put it into practice.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search lessons or topics',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => setState(() => _query = value),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: topics.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) => ChoiceChip(
                          label: Text(topics[index]),
                          selected: _topic == topics[index],
                          onSelected: (_) =>
                              setState(() => _topic = topics[index]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        Text(
                          _favoritesOnly ? 'Saved lessons' : 'Explore lessons',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          '${filtered.length} lessons',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: _message(
                    Icons.search_off_rounded,
                    'No lessons found',
                    'Try another search or topic.',
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 32),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.crossAxisExtent;
                      final columns = width >= 900
                          ? 3
                          : width >= 560
                          ? 2
                          : 1;
                      final textScale = MediaQuery.textScalerOf(context)
                          .scale(1)
                          .clamp(1.0, 1.7)
                          .toDouble();
                      return SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 192 * textScale,
                        ),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final lesson = filtered[index];
                          return _LessonCard(
                            lesson: lesson,
                            isFavorite: _favorites.contains(lesson.id),
                            onFavorite: () => setState(
                              () => _favorites.contains(lesson.id)
                                  ? _favorites.remove(lesson.id)
                                  : _favorites.add(lesson.id),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => LessonDetailPage(
                                  lesson: lesson,
                                  isFavorite: _favorites.contains(lesson.id),
                                  onFavorite: () => setState(
                                    () => _favorites.contains(lesson.id)
                                        ? _favorites.remove(lesson.id)
                                        : _favorites.add(lesson.id),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, childCount: filtered.length),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    ),
  );

  Widget _message(
    IconData icon,
    String title,
    String detail, {
    String? actionLabel,
    VoidCallback? onAction,
  }) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 42, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(actionLabel),
            ),
          ],
        ],
      ),
    ),
  );
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.lesson,
    required this.isFavorite,
    required this.onFavorite,
    required this.onTap,
  });
  final Lesson lesson;
  final bool isFavorite;
  final VoidCallback onFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Chip(
                      label: Text(
                        lesson.topic,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide.none,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondaryContainer,
                    ),
                  ),
                ),
                IconButton(
                  tooltip: isFavorite ? 'Remove favorite' : 'Add favorite',
                  onPressed: onFavorite,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite
                        ? Theme.of(context).colorScheme.error
                        : null,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              lesson.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Text(
                lesson.summary,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Open lesson',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({
    super.key,
    required this.lesson,
    required this.isFavorite,
    required this.onFavorite,
  });
  final Lesson lesson;
  final bool isFavorite;
  final VoidCallback onFavorite;

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  late bool _isFavorite = widget.isFavorite;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.lesson.topic),
      actions: [
        IconButton(
          tooltip: _isFavorite ? 'Remove favorite' : 'Add favorite',
          onPressed: () {
            widget.onFavorite();
            setState(() => _isFavorite = !_isFavorite);
          },
          icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      children: [
        Text(
          widget.lesson.title,
          style: Theme.of(context).textTheme.headlineMedium
              ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.7),
        ),
        const SizedBox(height: 24),
        LessonBody(markdown: widget.lesson.body),
        const SizedBox(height: 32),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      'Put it into practice',
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.lesson.exercise,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.6),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Renders the small Markdown subset used by the curriculum: `##` headings,
/// blank-line paragraphs, and inline backtick code spans.
class LessonBody extends StatelessWidget {
  const LessonBody({super.key, required this.markdown});

  final String markdown;

  @override
  Widget build(BuildContext context) {
    final blocks = <Widget>[];
    final paragraph = <String>[];

    void flushParagraph() {
      if (paragraph.isEmpty) return;
      blocks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text.rich(
            _inlineCode(paragraph.join(' '), Theme.of(context)),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
          ),
        ),
      );
      paragraph.clear();
    }

    for (final rawLine in markdown.split('\n')) {
      final line = rawLine.trim();
      if (line.isEmpty) {
        flushParagraph();
      } else if (line.startsWith('## ')) {
        flushParagraph();
        blocks.add(
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 8),
            child: Text(
              line.substring(3),
              style: Theme.of(context).textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        );
      } else {
        paragraph.add(line);
      }
    }
    flushParagraph();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks,
    );
  }

  TextSpan _inlineCode(String text, ThemeData theme) {
    final codeStyle = TextStyle(
      fontFamily: 'monospace',
      color: theme.colorScheme.onSecondaryContainer,
      backgroundColor: theme.colorScheme.secondaryContainer,
    );
    final spans = <InlineSpan>[];
    final pattern = RegExp(r'`([^`]+)`');
    var start = 0;
    for (final match in pattern.allMatches(text)) {
      if (match.start > start) {
        spans.add(TextSpan(text: text.substring(start, match.start)));
      }
      spans.add(TextSpan(text: match.group(1), style: codeStyle));
      start = match.end;
    }
    if (start < text.length) spans.add(TextSpan(text: text.substring(start)));
    return TextSpan(children: spans);
  }
}
