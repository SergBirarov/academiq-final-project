import { Router } from 'express';
import { createAssignment, deleteAssignment, editAssignment, getAssignment, submittingAssignment } from './assignments.controller';

const assignmentRouter = Router();

assignmentRouter
  .get('/', getAssignment)
  .put('/create', createAssignment)
  .post('/edit', editAssignment)
  .post('/submit', submittingAssignment)
  .delete('/delete', deleteAssignment)


export default assignmentRouter; 
