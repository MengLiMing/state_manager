// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeNotifierProxyProviderPage extends StatelessWidget {
  const ChangeNotifierProxyProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => _Letters()),
        ChangeNotifierProxyProvider<_Letters, _LikeLetters>(
          create: (_) => _LikeLetters(),
          update: (context, value, like) {
            return like!..updateLetters(value.letters);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('data')),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Expanded(child: AllListView()),
            Divider(),
            Expanded(child: LikeListView()),
          ],
        ),
      ),
    );
  }
}

class AllListView extends StatelessWidget {
  const AllListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letters =
        context.select<_Letters, List<String>>((value) => value.letters);
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        final letter = letters[index];
        return Row(children: [
          Expanded(
            child: Text(letter),
          ),
          LikeButton(
            letter: letter,
          ),
        ]);
      },
      itemExtent: 50,
      itemCount: letters.length,
    );
  }
}

class LikeListView extends StatelessWidget {
  const LikeListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letters = context.watch<_LikeLetters>().like;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      itemBuilder: (context, index) {
        final letter = letters[index];
        return Text(letter);
      },
      itemExtent: 50,
      itemCount: letters.length,
    );
  }
}

class LikeButton extends StatelessWidget {
  final String letter;
  const LikeButton({
    Key? key,
    required this.letter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _like = context.watch<_LikeLetters>();
    final isLike = _like.isLike(letter);
    return TextButton(
        onPressed: () {
          isLike ? _like.removeLetter(letter) : _like.addLetter(letter);
        },
        child: Text(isLike ? "不喜欢" : "喜欢"));
  }
}

class _Letters {
  List<String> letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
  ];
}

class _LikeLetters extends ChangeNotifier {
  late List<String> _letters;

  List<String> get letters => _letters;

  List<String> like = [];

  void updateLetters(List<String> value) {
    _letters = value;
    notifyListeners();
  }

  bool isLike(String letter) => like.contains(letter);

  void addLetter(String letter) {
    like.add(letter);

    notifyListeners();
  }

  void removeLetter(String letter) {
    like.remove(letter);

    notifyListeners();
  }
}
