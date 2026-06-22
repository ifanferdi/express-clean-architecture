import express from 'express';
import PermissionController from '../controller/permission-controller';

export default function PermissionRoutes(controller: PermissionController) {
  const router = express.Router();

  router
    .get('/', controller.findAll)
    .get('/:id', controller.findOne)
    .post('/get', controller.findAll)
    .post('/', controller.create)
    .post('/check-valid-permissions', controller.checkValidPermission)
    .put('/:id', controller.update)
    .delete('/:id', controller.destroy);

  return router;
}
