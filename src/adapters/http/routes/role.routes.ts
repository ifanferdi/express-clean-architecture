import express from 'express';
import RoleController from '../controller/role-controller';

export default function RoleRoutes(controller: RoleController) {
  const router = express.Router();

  router
    .post('/get', controller.findAll)
    .get('/', controller.findAll)
    .get('/:id', controller.findOne)
    .post('/', controller.create)
    .put('/:id', controller.update)
    .delete('/:id', controller.destroy)
    .post('/assign-permissions', controller.assignPermissions);

  return router;
}
