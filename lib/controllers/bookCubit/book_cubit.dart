import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/config/app_utility.dart';
import 'package:e_book/models/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(const BookState());

  TextEditingController titleController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController aboutAuthController = TextEditingController();
  TextEditingController pagesController = TextEditingController();
  TextEditingController audioLenController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth fAuth = FirebaseAuth.instance;
  ImagePicker imagePicker = ImagePicker();
  List<BookModel> currentUserBooksList = [];
  List<BookModel> bookDataList = [];
  bool isImageUploading = false;
  bool isPdfUploading = false;
  bool isPostUploading = true;
  String imageUrl = "";
  String pdfUrl = "";
  int index = 0;

  getAllBooks() async {
    bookDataList.clear();
    emit(const BookState(isLoading: true));
    try {
      var booksSnapshot = await db.collection("Books").get();
      List<BookModel> books = booksSnapshot.docs
          .map((doc) => BookModel.fromJson(doc.data()))
          .toList();
      bookDataList.addAll(List.from(books));
      emit(state.copyWith(isLoading: false, allBooks: books));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  getUserBook() async {
    emit(const BookState(isLoading: true, userBooks: []));
    currentUserBooksList.clear();
    try {
      var user = fAuth.currentUser;
      if (user != null) {
        var booksSnapshot = await db
            .collection("userBook")
            .doc(user.uid)
            .collection("Books")
            .get();
        List<BookModel> userBooks = booksSnapshot.docs
            .map((doc) => BookModel.fromJson(doc.data()))
            .toList();
        currentUserBooksList.addAll(userBooks);
        emit(state.copyWith(isLoading: false, userBooks: userBooks));
      } else {
        emit(state.copyWith(
            isLoading: false, errorMessage: "User not logged in"));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  pickImage() async {
    isImageUploading = true;
    emit(state.copyWith(isImageUploading: true, pickedImageUrl: ""));
    try {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        debugPrint("image path: ${image.path}");
        imageUrl = await uploadImageToFirebase(File(image.path));
      } else {
        imageUrl = '';
      }
      isImageUploading = false;
      debugPrint("Download Image URL: $imageUrl");
      emit(state.copyWith(isImageUploading: false, pickedImageUrl: imageUrl));
    } catch (e) {
      emit(state.copyWith(
          isImageUploading: false, imagePickErrorMessage: e.toString()));
    }
  }

  Future<String> uploadImageToFirebase(File image) async {
    try {
      var uuid = const Uuid();
      var filename = uuid.v1();
      var storageRef = storage.ref().child("Images/$filename");
      // ignore: unused_local_variable
      var response = await storageRef.putFile(image);
      String downloadURL = await storageRef.getDownloadURL();
      imageUrl = downloadURL;
      // debugPrint("Download URL: $downloadURL");
      return imageUrl;
    } catch (e) {
      debugPrint("Error in creating Download URL: $e");
      emit(state.copyWith(
        isImageUploading: false,
        imagePickErrorMessage: "Error in upload image to server",
      ));
      return "";
    } finally {
      isImageUploading = false;
    }
  }

  createBook() async {
    try {
      emit(state.copyWith(
        isBookUploading: true,
        isBookUploadedSuccessfully: false,
      ));
      isPostUploading = true;
      var newBook = BookModel(
        id: "$index",
        title: titleController.text,
        description: desController.text,
        coverUrl: imageUrl,
        bookurl: pdfUrl,
        author: authorController.text,
        aboutAuthor: aboutAuthController.text,
        price: int.parse(priceController.text),
        pages: int.parse(pagesController.text),
        language: languageController.text,
        audioLen: audioLenController.text,
        audioUrl: "",
        rating: "",
      );
      await db.collection("Books").add(newBook.toJson());
      addBookInUserDb(newBook);
      isPostUploading = false;
      titleController.clear();
      desController.clear();
      aboutAuthController.clear();
      pagesController.clear();
      languageController.clear();
      audioLenController.clear();
      authorController.clear();
      priceController.clear();
      imageUrl = "";
      pdfUrl = "";
      getAllBooks();
      getUserBook();
      emit(state.copyWith(
        isBookUploading: false,
        isBookUploadedSuccessfully: true,
      ));
      successMessage("Book added to the db");
    } catch (e) {
      emit(state.copyWith(
        isBookUploading: false,
        isBookUploadedSuccessfully: false,
      ));
    }
  }

  cancelUploadingBook() {
    isPostUploading = false;
    titleController.clear();
    desController.clear();
    aboutAuthController.clear();
    pagesController.clear();
    languageController.clear();
    audioLenController.clear();
    authorController.clear();
    priceController.clear();
    imageUrl = "";
    pdfUrl = "";
    emit(state.copyWith(
      isImageUploading: false,
      isPdfUploading: false,
      imagePickErrorMessage: "",
      pickedImageUrl: "",
      pickedPdfUrl: "",
      pickedPdfFilePath: "",
      pdfPickErrorMessage: "",
    ));
  }

  void addBookInUserDb(BookModel book) async {
    await db
        .collection("userBook")
        .doc(fAuth.currentUser!.uid)
        .collection("Books")
        .add(book.toJson());
  }

  pickPDF() async {
    try {
      isPdfUploading = true;
      emit(state.copyWith(
        isPdfUploading: true,
        pickedPdfUrl: "",
        pickedPdfFilePath: "",
      ));

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        File file = File(result.files.first.path!);
        if (file.existsSync()) {
          Uint8List fileBytes = await file.readAsBytes();
          String fileName = result.files.first.name;
          String filePath = "Pdf/$fileName";
          debugPrint("File Bytes: $fileBytes");
          final response =
              await storage.ref().child(filePath).putData(fileBytes);
          final downloadURL = await response.ref.getDownloadURL();
          pdfUrl = downloadURL;
          debugPrint("Download Pdf URL: $downloadURL");
          emit(state.copyWith(
            isPdfUploading: false,
            pickedPdfUrl: downloadURL,
            pickedPdfFilePath: filePath,
          ));
        } else {
          debugPrint("File does not exist");
          emit(state.copyWith(
              isPdfUploading: false,
              pdfPickErrorMessage: "File does not exist"));
        }
      } else {
        debugPrint("No file selected");
        emit(state.copyWith(
            isPdfUploading: false, pdfPickErrorMessage: "No file selected"));
      }
    } catch (e) {
      emit(state.copyWith(
          isPdfUploading: false, pdfPickErrorMessage: e.toString()));
    } finally {
      isPdfUploading = false;
    }
  }

  deletekPDF(String filePath) async {
    pdfUrl = "";
    if (filePath.toString().trim() != "") {
      try {
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child(filePath);
        // Delete the file
        await ref.delete();
        debugPrint('File deleted successfully');
      } catch (e) {
        debugPrint("Deleting Error: $e");
      }
    } else {
      debugPrint("Unable to delete");
    }
    emit(state.copyWith(pickedPdfUrl: ""));
  }
}
