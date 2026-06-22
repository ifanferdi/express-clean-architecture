import RedisConnection from '../redis-connection';

export type RedisClientType = Awaited<ReturnType<typeof RedisConnection>>;
