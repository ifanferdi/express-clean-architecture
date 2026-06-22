import { IUser } from '../../domain/entities/user';
import { UserRelation } from '../../domain/enums/user.enum';
import { ErrorNotFound } from '../../helpers/error.helper';
import { FindAllUserDto, FindByIdUserDto } from '../../validations/user-validation';
import BaseUseCase from '../_base-use-case';

export default class FindByIdUser extends BaseUseCase {
  async execute(params: FindByIdUserDto) {
    const user = (await this.repositories.userRepository.findOne(params)) as IUser;
    if (!user) throw new ErrorNotFound('Pengguna tidak ditemukan');

    this.extractRelationData(params, user);

    return user;
  }

  extractRelationData(params: FindAllUserDto | FindByIdUserDto, user: IUser) {
    const _handleRoles = (_user: IUser) => {
      _user.roles = _user.userHasRoles?.map((userHasRole) => userHasRole.role!);
      delete _user.userHasRoles;
    };
    const _handleRolePermissions = (_user: IUser) => {
      if (!_user.roles) _handleRoles(_user);
      _user.roles?.map((role) => {
        role.permissions = role.roleHasPermissions?.map(
          (roleHasPermission) => roleHasPermission.permission!,
        );

        return role;
      });
    };
    const _handlePermissions = (_user: IUser) => {
      if (!_user.roles) _handleRoles(_user);
      _user.permissions = [];
      _user.roles?.flatMap((role) =>
        role.roleHasPermissions?.map((roleHasPermission) =>
          _user.permissions?.push(roleHasPermission.permission!),
        ),
      );

      if (
        !params.with?.includes(UserRelation.ROLES) &&
        !params.with?.includes(UserRelation.ROLE_PERMISSIONS)
      )
        delete _user.roles;
    };

    if (params.with?.includes(UserRelation.ROLES)) _handleRoles(user);
    if (params.with?.includes(UserRelation.ROLE_PERMISSIONS)) _handleRolePermissions(user);
    if (params.with?.includes(UserRelation.PERMISSIONS)) _handlePermissions(user);

    if (user && user.roles) user.roles?.map((role) => delete role.roleHasPermissions);
  }
}
