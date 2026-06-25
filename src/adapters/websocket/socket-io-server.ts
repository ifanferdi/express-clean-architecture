import * as http from 'http';
import { Server } from 'socket.io';
import { UseCases } from '../../domain/use-cases/use-case.interface';
import socketIoHandlers from './handlers';

export default class SocketIoServer {
  constructor(
    private httpServer: http.Server,
    private useCases: UseCases,
  ) {}

  execute() {
    const io = new Server(this.httpServer, { cors: { origin: '*' } });

    socketIoHandlers(io, this.useCases);

    return io;
  }
}
