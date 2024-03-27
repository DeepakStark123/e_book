import 'package:e_book/controllers/bookCubit/book_cubit.dart';
import 'package:e_book/components/back_button.dart';
import 'package:e_book/components/mutiline_textform_field.dart';
import 'package:e_book/components/my_textformfield.dart';
import 'package:e_book/config/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBookPage extends StatelessWidget {
  const AddNewBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextEditingController bookTitlecontroller = TextEditingController();
    // PdfController pdfController = Get.put(PdfController());
    BookCubit bookCubit = context.read<BookCubit>();
    return Scaffold(
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
                            "ADD NEW BOOK",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                ),
                          ),
                          const SizedBox(width: 70)
                        ],
                      ),
                      const SizedBox(height: 60),
                      InkWell(
                        onTap: () {
                          bookCubit.pickImage();
                        },
                        child: BlocBuilder<BookCubit, BookState>(
                          buildWhen: (previous, current) {
                            return (previous.pickedImageUrl !=
                                    current.pickedImageUrl ||
                                previous.isImageUploading !=
                                    current.isImageUploading);
                          },
                          builder: (context, state) {
                            return Container(
                              height: 190,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Theme.of(context).colorScheme.background,
                              ),
                              child: Center(
                                child: state.isImageUploading
                                    ? const CircularProgressIndicator()
                                    : (state.pickedImageUrl == null ||
                                            state.pickedImageUrl == "")
                                        ? Image.asset(AppAssets.addIcon)
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              state.pickedImageUrl!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<BookCubit, BookState>(
                        buildWhen: (previous, current) {
                          return (previous.pickedPdfUrl !=
                                      current.pickedPdfUrl ||
                                  previous.isPdfUploading !=
                                      current.isPdfUploading ||
                                  previous.pickedPdfFilePath !=
                                      current.pickedPdfFilePath)
                              ? true
                              : false;
                        },
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: state.pickedPdfUrl == ""
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: state.isPdfUploading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.backgroudColor,
                                    ),
                                  )
                                : (state.pickedPdfUrl == "" ||
                                        state.pickedPdfUrl == null)
                                    ? InkWell(
                                        onTap: () {
                                          bookCubit.pickPDF();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(AppAssets.uploadIcon),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Book PDF",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .background,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          bookCubit.deletekPDF(
                                              state.pickedPdfFilePath ?? "");
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppAssets.deleteIcon,
                                              width: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              "Delete Pdf",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Book title",
                  icon: Icons.book,
                  controller: bookCubit.titleController,
                ),
                const SizedBox(height: 10),
                MultiLineTextField(
                  hintText: "Book Description",
                  controller: bookCubit.desController,
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "Author Name",
                  icon: Icons.person,
                  controller: bookCubit.authorController,
                ),
                const SizedBox(height: 10),
                MyTextFormField(
                  hintText: "About Author",
                  icon: Icons.person,
                  controller: bookCubit.aboutAuthController,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        isNumber: true,
                        hintText: "Price",
                        icon: Icons.currency_rupee,
                        controller: bookCubit.priceController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Pages",
                        isNumber: true,
                        icon: Icons.book,
                        controller: bookCubit.pagesController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Language",
                        icon: Icons.language,
                        controller: bookCubit.languageController,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: MyTextFormField(
                        hintText: "Audio Len",
                        icon: Icons.audiotrack,
                        controller: bookCubit.audioLenController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.red,
                            )),
                        child: InkWell(
                          onTap: () {
                            bookCubit.cancelUploadingBook();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "CANCLE",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: Colors.red,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: BlocBuilder<BookCubit, BookState>(
                        buildWhen: (previous, current) {
                          return (previous.isBookUploadedSuccessfully !=
                                  current.isBookUploadedSuccessfully ||
                              previous.isBookUploading !=
                                  current.isBookUploading);
                        },
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: state.isBookUploading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : InkWell(
                                    onTap: () {
                                      bookCubit.createBook();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.upload_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .background,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "POST",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .background,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
