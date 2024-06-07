import { Router } from 'express';
import { createNote, deleteFromNote, uploadToNote } from './courseNote.controller';

const courseNoteRouter = Router();

courseNoteRouter
  .get('/', uploadToNote)
  .post('/create', createNote)
  .delete('/delete', deleteFromNote)


export default courseNoteRouter; 
