import 'package:e_book/controllers/authCubit/auth_cubit.dart';
import 'package:e_book/controllers/bookCubit/book_cubit.dart';
import 'package:e_book/components/back_button.dart';
import 'package:e_book/components/book_tile.dart';
import 'package:e_book/config/export.dart';
import 'package:e_book/presentation/AddNewBook/add_new_book.dart';
import 'package:e_book/presentation/BookDetails/book_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = context.read<AuthCubit>();
    // BookController bookController = Get.put(BookController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewBookPage(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: 500,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              color: Theme.of(context).colorScheme.primary,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MyBackButton(),
                          Text(
                            "Profile",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          IconButton(
                              onPressed: () {
                                authCubit.signout(context);
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Theme.of(context).colorScheme.background,
                              ))
                        ],
                      ),
                      const SizedBox(height: 60),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              width: 2,
                              color: Theme.of(context).colorScheme.background,
                            )),
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: authCubit.auth.currentUser == null
                                ? Image.asset(
                                    AppAssets.userProfileImage,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    authCubit.auth.currentUser == null
                                        ? AppAssets.userProfileImage
                                        : "${authCubit.auth.currentUser!.photoURL}",
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (authCubit.auth.currentUser?.displayName != null) ...[
                        Text(
                          authCubit.auth.currentUser?.displayName ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background),
                        ),
                      ],
                      if (authCubit.auth.currentUser?.email != null) ...[
                        Text(
                          authCubit.auth.currentUser?.email ?? "",
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                      ]
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Your Books",
                          style: Theme.of(context).textTheme.labelMedium),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                                          .map((e) => BookTile(
                                                title: e.title!,
                                                coverUrl: e.coverUrl!,
                                                author: e.author!,
                                                price: e.price!,
                                                rating: e.rating!,
                                                totalRating: 12,
                                                ontap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          BookDetails(book: e),
                                                    ),
                                                  );
                                                },
                                              ))
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
