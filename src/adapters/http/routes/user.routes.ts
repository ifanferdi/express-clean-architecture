import express from 'express';
import UserController from '../controller/user-controller';

export default function UserRoutes(controller: UserController) {
  const router = express.Router();

  router
    .get('/', controller.findAll)
    .get('/:id', controller.findOne)
    .post('/get', controller.findAll)
    .post('/:id/restore', controller.restore)
    .post('/profile/upload', controller.upload, controller.uploadImage)
    .post('/', controller.create)
    .put('/:id', controller.update)
    .delete('/:id', controller.destroy)
    .delete('/:id/permanently', controller.destroyPermanently);

  return router;
}
