part of 'book_cubit.dart';

class BookState extends Equatable {
  final bool isLoading;
  final bool isImageUploading;
  final bool isPdfUploading;
  final bool isBookUploading;
  final bool isBookUploadedSuccessfully;
  final List<BookModel>? allBooks;
  final List<BookModel>? userBooks;
  final String? errorMessage;
  final String? imagePickErrorMessage;
  final String? pickedImageUrl;
  final String? pickedPdfUrl;
  final String? pickedPdfFilePath;
  final String? pdfPickErrorMessage;

  const BookState({
    this.isLoading = false,
    this.isImageUploading = false,
    this.isPdfUploading = false,
    this.isBookUploading = false,
    this.isBookUploadedSuccessfully = false,
    this.allBooks = const <BookModel>[],
    this.userBooks = const <BookModel>[],
    this.errorMessage = '',
    this.imagePickErrorMessage = '',
    this.pickedImageUrl = '',
    this.pickedPdfUrl = '',
    this.pickedPdfFilePath = '',
    this.pdfPickErrorMessage = '',
  });

  BookState copyWith({
    bool? isLoading,
    bool? isImageUploading,
    bool? isPdfUploading,
    bool? isBookUploading,
    bool? isBookUploadedSuccessfully,
    List<BookModel>? allBooks,
    List<BookModel>? userBooks,
    String? errorMessage,
    String? imagePickErrorMessage,
    String? pickedImageUrl,
    String? pickedPdfUrl,
    String? pickedPdfFilePath,
    String? pdfPickErrorMessage,
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      isImageUploading: isImageUploading ?? this.isImageUploading,
      isPdfUploading: isPdfUploading ?? this.isPdfUploading,
      isBookUploading: isBookUploading ?? this.isBookUploading,
      isBookUploadedSuccessfully:
          isBookUploadedSuccessfully ?? this.isBookUploadedSuccessfully,
      allBooks: allBooks ?? this.allBooks,
      userBooks: userBooks ?? this.userBooks,
      errorMessage: errorMessage ?? this.errorMessage,
      imagePickErrorMessage:
          imagePickErrorMessage ?? this.imagePickErrorMessage,
      pickedImageUrl: pickedImageUrl ?? this.pickedImageUrl,
      pickedPdfUrl: pickedPdfUrl ?? this.pickedPdfUrl,
      pickedPdfFilePath: pickedPdfFilePath ?? this.pickedPdfFilePath,
      pdfPickErrorMessage: pdfPickErrorMessage ?? this.pdfPickErrorMessage,
    );
  }

  @override
  String toString() {
    return '''PostState { isLoading: $isLoading, allBooks: $allBooks, userBooks: $userBooks, errorMessage: $errorMessage, imagePickErrorMessage: $imagePickErrorMessage,pickedImage : $pickedImageUrl,pickedPdfUrl : $pickedPdfUrl, pdfPickErrorMessage:$pdfPickErrorMessage, pickedPdfFilePath:$pickedPdfFilePath,isBookUploading: $isBookUploading, isBookUploadedSuccessfully: $isBookUploadedSuccessfully}''';
  }

  @override
  List<Object?> get props => [
        isLoading,
        isImageUploading,
        isPdfUploading,
        isPdfUploading,
        isBookUploadedSuccessfully,
        allBooks,
        userBooks,
        errorMessage,
        imagePickErrorMessage,
        pickedImageUrl,
        pickedPdfUrl,
        pickedPdfFilePath,
        pdfPickErrorMessage,
      ];
}
