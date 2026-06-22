import CreateRole from '../create-role';
import DeleteRole from '../delete-role';
import FindAllRole from '../find-all-role';
import FindByIdRole from '../find-by-id-role';
import RoleAssignPermission from '../role-assign-permission';
import UpdateRole from '../update-role';

export interface RoleUseCase {
  findAllRole: FindAllRole;
  findByIdRole: FindByIdRole;
  createRole: CreateRole;
  updateRole: UpdateRole;
  deleteRole: DeleteRole;
  roleAssignPermission: RoleAssignPermission;
}
