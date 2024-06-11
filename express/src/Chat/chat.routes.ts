import { Router } from 'express';
import { generateKey, getMsg, sendMsg } from './Chat.controller';

const chatRouter = Router();

chatRouter
  .get('/', getMsg)
  .get('/genKey', generateKey)
  .post('/send', sendMsg)



export default chatRouter; 
