import { Router } from 'express';
import { deleteFromTable, insertToTable } from './admin.controller';

const adminRouter = Router();

adminRouter
  .post('/insert', insertToTable)
  .delete('/delete', deleteFromTable)

export default adminRouter; 
