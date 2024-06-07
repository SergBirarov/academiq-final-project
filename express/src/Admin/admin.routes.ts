import { Router } from 'express';
import { deleteUser, findAllUsers, loginUser, registerUser, updateUser } from './admin.controller';

const userRouter = Router();

userRouter
  .get('/', findAllUsers)
  .post('/register', registerUser)
  .post('/login', loginUser)
  .put('/update', updateUser)
  .delete('/delete', deleteUser)


export default userRouter; 
