import { CommonUseCase } from './common.interface';
import { PermissionUseCase } from './permission.interface';
import { RoleUseCase } from './role.interface';
import { UserUseCase } from './user.interface';

export interface UseCases {
  userUseCase: UserUseCase;
  permissionUseCase: PermissionUseCase;
  roleUseCase: RoleUseCase;
  commonUseCase: CommonUseCase;
}
