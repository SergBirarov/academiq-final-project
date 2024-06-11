import { Router } from 'express';
import { deleteSharing, getByCouseId, shareToCourse } from './sharingSys.controller';

const sharingSysRouter = Router();

sharingSysRouter
  .get('/', getByCouseId)
  .post('/share', shareToCourse)
  .delete('/delete', deleteSharing)



export default sharingSysRouter; 
