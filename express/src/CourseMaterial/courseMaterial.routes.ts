import { Router } from 'express';
import { deleteFromCourse, getCourseMaterial, setVisibility, uploadToCourse } from './courseMaterial.controller';

const courseMateialRouter = Router();

courseMateialRouter
  .get('/', getCourseMaterial)
  .post('/upload', uploadToCourse)
  .delete('/delete', deleteFromCourse)
  .post('/visibility', setVisibility)


export default courseMateialRouter; 
