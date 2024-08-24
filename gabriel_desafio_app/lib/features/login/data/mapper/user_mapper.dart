import '../../domain/entities/user.dart';
import '../models/user_model.dart';

class UserMapper {
  static UserModel toModel(User user) {
    return UserModel(
      user: user.user,
      password: user.password,
    );
  }

  static User toEntity(UserModel model) {
    return User(
      user: model.user,
      password: model.password,
    );
  }
}
