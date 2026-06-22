import { Express } from 'express';
import { Controllers } from '../controller/interfaces/controller.interface';
import PermissionRoutes from './permission.routes';
import RoleRoutes from './role.routes';
import UserRoutes from './user.routes';

export default function Routes(app: Express, controllers: Controllers) {
  app.get('/api/v1/dashboard', controllers.dashboardController.index);
  app.use('/api/v1/users', UserRoutes(controllers.userController));
  app.use('/api/v1/permissions', PermissionRoutes(controllers.permissionController));
  app.use('/api/v1/roles', RoleRoutes(controllers.roleController));
}
