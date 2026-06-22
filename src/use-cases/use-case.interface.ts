import { CommonUseCase } from './common/interfaces/common.interface';
import { PermissionUseCase } from './permission/interfaces/permission.interface';
import { RoleUseCase } from './role/interfaces/role.interface';
import { UserUseCase } from './user/interfaces/user.interface';

export interface UseCases {
  userUseCase: UserUseCase;
  permissionUseCase: PermissionUseCase;
  roleUseCase: RoleUseCase;
  commonUseCase: CommonUseCase;
}
