import CreateUser from '../create-user';
import DeleteUser from '../delete-user';
import FindAllUser from '../find-all-user';
import FindByIdUser from '../find-by-id-user';
import ProfileImage from '../profile-image';
import RestoreUser from '../restore-user';
import UpdateUser from '../update-user';

export interface UserUseCase {
  findAllUser: FindAllUser;
  createUser: CreateUser;
  findByIdUser: FindByIdUser;
  updateUser: UpdateUser;
  deleteUser: DeleteUser;
  restoreUser: RestoreUser;
  profileImage: ProfileImage;
}
