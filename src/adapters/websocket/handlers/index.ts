import { Server } from 'socket.io';
import { UseCases } from '../../../domain/use-cases/use-case.interface';
import chatHandlers from './chat-handlers';

export default function socketIoHandlers(io: Server, useCases: UseCases) {
  chatHandlers(io, useCases);

  io.on('connection', (socket) => {
    console.log(`✅ New user connected socketId:${socket.id}`);

    // 1. Join Room
    socket.on('join_project', (msg) => {
      socket.join('projectId:' + msg.projectId);
      socket.emit('joined', `socketId:${socket.id} join project:${msg.projectId}`);
    });

    // emit task to all user in project
    socket.on('send_task', (msg) => {
      socket.to('projectId:' + msg.projectId).emit('task_updated', { task: msg.task });
    });

    socket.on('typing', (msg) => {
      socket.volatile
        .to('projectId:' + msg.projectId)
        .emit('user_typing', `$socketId:${socket.id} is typing...`);
    });

    socket.on('disconnect', (reason) => {
      console.log(`❌ socketId:${socket.id} disconnected: ${reason}`);
    });
  });
}
