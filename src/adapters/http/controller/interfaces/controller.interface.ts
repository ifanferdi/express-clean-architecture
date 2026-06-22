import DashboardController from '../dashboard-controller';
import PermissionController from '../permission-controller';
import RoleController from '../role-controller';
import UserController from '../user-controller';

export interface Controllers {
  dashboardController: DashboardController;
  userController: UserController;
  roleController: RoleController;
  permissionController: PermissionController;
}
