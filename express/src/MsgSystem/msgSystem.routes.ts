import { Router } from 'express';
import { createMsg, deleteMsg, readMsg } from './msgSystem.controller';

const MsgSystemRouter = Router();

MsgSystemRouter
  .get('/', readMsg)
  .post('/send', createMsg)
  .delete('/del', deleteMsg)
 


export default MsgSystemRouter; 
