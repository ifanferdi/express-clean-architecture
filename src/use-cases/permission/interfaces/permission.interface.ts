import CheckValidPermission from '../check-valid-permission';
import CreatePermission from '../create-permission';
import DeletePermission from '../delete-permission';
import FindAllPermission from '../find-all-permission';
import FindByIdPermission from '../find-by-id-permission';
import ResetCachePermission from '../reset-cache-permission';
import UpdatePermission from '../update-permission';

export interface PermissionUseCase {
  findAllPermission: FindAllPermission;
  createPermission: CreatePermission;
  findByIdPermission: FindByIdPermission;
  updatePermission: UpdatePermission;
  deletePermission: DeletePermission;
  checkValidPermission: CheckValidPermission;
  resetCachePermission: ResetCachePermission;
}
