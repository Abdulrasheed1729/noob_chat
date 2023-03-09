import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noob_chat/repositories/repositories.dart';
import 'package:noob_chat/utils/utils.dart';

part 'sign_up_state.dart';

///
class SignUpCubit extends Cubit<SignUpState> {
  /// {@macro sign_up_cubit}
  SignUpCubit(
    this._authRepository,
    this._storageRepository,
    this._userRepository,
  ) : super(const SignUpState());

  final AuthRepository _authRepository;

  final StorageRepository _storageRepository;

  final UserRepository _userRepository;

  final _imagePicker = ImagePicker();

  ///
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([
          email,
          state.password,
          state.confirmedPassword,
          state.name,
          state.imageUrl,
        ]),
      ),
    );
  }

  ///
  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.name,
          state.imageUrl,
          password,
          confirmedPassword,
        ]),
      ),
    );
  }

  ///
  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate([
          state.email,
          state.password,
          state.name,
          state.imageUrl,
          confirmedPassword,
        ]),
      ),
    );
  }

  ///
  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        status: Formz.validate([
          name,
          state.email,
          state.password,
          state.confirmedPassword,
          state.imageUrl,
        ]),
      ),
    );
  }

  ///
  // void imageUrlChanged(String value) {
  //   final imageUrl = ImageUrl.dirty(value);
  //   emit(
  //     state.copyWith(
  //       imageUrl: imageUrl,
  //       status: Formz.validate([
  //         state.name,
  //         state.email,
  //         state.password,
  //         state.confirmedPassword,
  //         imageUrl,
  //       ]),
  //     ),
  //   );
  // }

  // String _getUploadedImageUrl(Uint8List imageFile) {
  //   final
  // }

  ///
  Future<void> uploadImage() async {
    final imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    final file = await imageFile!.readAsBytes();
    final fileUrl = await _storageRepository.uploadImageData(
      imageFile.name,
      file,
    );
    final imageUrl = ImageUrl.dirty(fileUrl);
    emit(
      state.copyWith(
        imageUrl: imageUrl,
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          state.confirmedPassword,
          imageUrl,
        ]),
      ),
    );
  }

  ///
  Future<void> signUp() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      await _userRepository.addUserData(
        _authRepository.currentUser.toUser.copyWith(
          firstName: state.name.value,
          imageUrl: state.imageUrl.value,
        ),
      );

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
