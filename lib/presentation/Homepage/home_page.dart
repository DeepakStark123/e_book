import 'package:e_book/controllers/bookCubit/book_cubit.dart';
import 'package:e_book/components/book_card.dart';
import 'package:e_book/components/book_tile.dart';
import 'package:e_book/models/book_data.dart';
import 'package:e_book/presentation/BookDetails/book_details.dart';
import 'package:e_book/presentation/Homepage/Widgets/app_bar.dart';
import 'package:e_book/presentation/Homepage/Widgets/category_widget.dart';
import 'package:e_book/presentation/Homepage/Widgets/my_Inpute_text_field.dart';
import 'package:e_book/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BookCubit bookCubit;

  @override
  void initState() {
    super.initState();
    bookCubit = context.read<BookCubit>();
    bookCubit.getAllBooks();
    bookCubit.getUserBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              color: Theme.of(context).colorScheme.primary,
              // height: 500,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const HomeAppBar(),
                        const SizedBox(height: 50),
                        Row(
                          children: [
                            Text(
                              "Good Morining✌️",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                            Text(
                              "Deepak",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Time to read book and enhance your knowledge",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const MyInputTextField(),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              "Topics",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categoryData
                                .map(
                                  (e) => CategoryWidget(
                                      iconPath: e["icon"]!,
                                      btnName: e["lebel"]!),
                                )
                                .toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Trending",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //----
                  BlocBuilder<BookCubit, BookState>(
                    buildWhen: (previous, current) {
                      return previous.allBooks != current.allBooks;
                    },
                    builder: (context, state) {
                      return state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : (state.errorMessage!.isNotEmpty ||
                                  state.errorMessage != "")
                              ? const Text("Error")
                              : (state.allBooks!.isNotEmpty)
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: state.allBooks!
                                            .map(
                                              (e) => BookCard(
                                                title: e.title!,
                                                coverUrl: e.coverUrl!,
                                                ontap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookDetails(book: e),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    )
                                  : const SizedBox();
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Your Interests",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<BookCubit, BookState>(
                    buildWhen: (previous, current) {
                      return previous.userBooks != current.userBooks;
                    },
                    builder: (context, state) {
                      return state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : (state.errorMessage!.isNotEmpty ||
                                  state.errorMessage != "")
                              ? const Text("Error")
                              : (state.userBooks!.isNotEmpty)
                                  ? Column(
                                      children: state.userBooks!
                                          .map(
                                            (e) => BookTile(
                                              ontap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookDetails(
                                                      book: e,
                                                    ),
                                                  ),
                                                );
                                              },
                                              title: e.title!,
                                              coverUrl: e.coverUrl!,
                                              author: e.author!,
                                              price: e.price!,
                                              rating: e.rating!,
                                              totalRating: 12,
                                            ),
                                          )
                                          .toList(),
                                    )
                                  : const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
