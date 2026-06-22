import PermissionRepository from './database/permission-repository';
import RoleRepository from './database/role-repository';
import UserRepository from './database/user-repository';
import LocalFilesystem from './filesystem/local-storage-repository';
import S3Filesystem from './filesystem/s3-storage-repository';
import RabbitmqRepository from './rabbitmq/rabbitmq-repository';
import RedisRepository from './redis/redis-repository';

export interface Repositories extends ToolsRepository {
  userRepository: UserRepository;
  roleRepository: RoleRepository;
  permissionRepository: PermissionRepository;
}

interface ToolsRepository {
  rabbitmqRepository?: RabbitmqRepository;
  redisRepository?: RedisRepository;
  storageRepository?: S3Filesystem | LocalFilesystem;
}
