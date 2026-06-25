import { Repositories } from '../domain/repositories/repository.interface';

export default abstract class BaseUseCase {
  constructor(protected repositories: Repositories) {}
}
