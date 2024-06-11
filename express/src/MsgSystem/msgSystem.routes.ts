import { Router } from 'express';
import { createMsg, deleteMsg, readMsg } from './msgSystem.controller';

const MsgSystemRouter = Router();

MsgSystemRouter
  .get('/:{id}/', readMsg)//??
  .post('/:{id}/send', createMsg)
  .delete('/:{id}/del', deleteMsg)
 


export default MsgSystemRouter; 
