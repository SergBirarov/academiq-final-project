
/*
  Functions dictionary: (ctrl + f with this)
    addAssignmentToStudent - assign a task to a student
      $push
    submitAssignment - submit by student
      $set
      arrayFilters
    gradeAssignment - grade by professor
      $set
    insertMark - add grades to final semester evaluation table
      $addToSet
    countStudentsInCourse - return number of students in a course
      $match
      $count
    getUnsubmittedAssignments - to get the ids of assignments missed by the student
      $unwind
      $group
      $push
    getSemesterAvgByCourse - semester average of a student 
      $project
    getYearAvgByCourse - course average for a student
      $filter
    getYearAvgByCourse - just like it sounds
      $concatArrays
      $avg
    updateProfileImage - same
    allSubmittedAssignmentsSorted - all submitted assignments by student sorted by 
                                    the date it wan submmited.
      $find
        $sort
        $limit
        $toArray
    addCourseToStudent - assign a student a course 
      $addToSet
    addNewNotebook - a student adds a new file to a notebook or a new notebook
    increaseCoursePoints - add points (נקודות זכות) to a course 
    removeLastAssignment - pop out the last assignment uploaded
    backupAndDeleteStudents - recieves a year to backup, creates the needed collection,
                              duplicates the items and then delets them from the original.
      .includes
      .forEach
      $gte
      $lte
      .deleteMany
    getAccumulatedPointsPerStudent - returns a collection of all students by thier id's
                                     and the accumulated points from all courses that year.
      mapReduce
 */


const addAssignmentToStudent = (studentId, assignmentId) => {
  return db.students.updateOne(
    { _id: studentId },
    {
      $push: {
        assignments: {
          assignmentId: assignmentId,
        }
      }
    }
  );
};

const submitAssignment = (studentId, assignmentId, uploadedFile, date) => {
  return db.students.updateOne(
    { _id: studentId },
    {
      $set: {
        'assignments.$[elem].assignmentId': assignmentId,
        'assignments.$[elem].uploadedFile': uploadedFile,
        'assignments.$[elem].date': ISODate(date)
      }
    },
    { arrayFilters: [{ 'elem.assignmentId': assignmentId }] }
  );
};

const gradeAssignment = (studentId, assignmentId, grade) => {
  return db.students.updateOne(
    { _id: studentId },
    {
      $set: {
        'assignments.$[elem].grade': grade
      }
    },
    { arrayFilters: [{ 'elem.assignmentId': assignmentId }] }
  );
};

const insertMark = (studentId, courseId, semester, mark) => {
  const semesterField = semester == "A" ? "semesterA" : "semesterB"

  return db.marks.updateOne(
    { studentId: studentId, [semesterField + '.courseId']: courseId },
    {
      $addToSet: {
        [semesterField + '.$[elem].grade']: mark
      }
    },
    { arrayFilters: [{ 'elem.courseId': courseId }] }
  );
};

const countStudentsInCourse = (id) => {
  return db.students.aggregate([
    {
      $match: {
        coursIds: { $in: [id] }
      }
    },
    {
      $count: "studentCount"
    }
  ])
}

const getUnsubmittedAssignments = (studentId) => {
  return db.students.aggregate([
    {
      $match: {
        _id: studentId
      }
    },
    {
      $unwind: "$assignments"
    },
    {
      $match: {
        "assignments.uploadedFile": null
      }
    },
    {
      $group: {
        _id: {
          firstName: "$firstName",
          lastName: "$lastName"
        },
        assignments: {
          $push: {
            assignmentId: "$assignments.assignmentId",
            uploadedFile: "$assignments.uploadedFile",
            date: "$assignments.date"
          }
        }
      }
    }
  ])
}

const getSemesterAvgByCourse = (studentId, courseId, semester) => {
  const semesterField = semester === 'A' ? 'semesterA' : 'semesterB';

  return db.marks.aggregate([
    { $match: { studentId } },

    { $unwind: `$${semesterField}` },

    { $match: { [`${semesterField}.courseId`]: courseId } },

    { $project: { grades: { $ifNull: [`$${semesterField}.grade`, []] } } },

    { $unwind: '$grades' },

    {
      $group: {
        _id: null,
        averageGrade: { $avg: '$grades' }
      }
    }
  ]);
};


const getSemesterAvgBySemester = (studentId, semester) => {

  const semesterField = semester == "A" ? "semesterA" : "semesterB"

  return db.marks.aggregate([
    {
      $match: {
        studentId
      }
    },
    {
      $project: {
        grades: `$${semesterField}`
      }
    },
    {
      $unwind: "$grades"
    },
    {
      $project: {
        courseId: "$grades.courseId",
        grade: { $avg: "$grades.grade" }
      }
    },
    {
      $group: {
        _id: null,
        averageGrade: { $avg: "$grade" }
      }
    }
  ])
}


const getYearAvgByCourse = (studentId, courseId) =>
  db.marks.aggregate([
    {
      $match: {
        studentId
      }
    },
    {
      $project: {
        semesterA: {
          $filter: {
            input: "$semesterA",
            as: "item",
            cond: { $eq: ["$$item.courseId", courseId] }
          }
        },
        semesterB: {
          $filter: {
            input: "$semesterB",
            as: "item",
            cond: { $eq: ["$$item.courseId", courseId] }
          }
        }
      }
    },
    {
      $project: {
        grades: {
          $concatArrays: [
            { $arrayElemAt: ["$semesterA.grade", 0] },
            { $arrayElemAt: ["$semesterB.grade", 0] }
          ]
        }
      }
    },
    {
      $unwind: "$grades"
    },
    {

      $group: {
        _id: null,
        averageGrade: { $avg: "$grades" }
      }
    }
  ])






const allSubmittedAssignmentsSorted = (id, numberOfAssingments) => {
  return db.students.find(
    { "_id": id },
    { "assignments": 1, "_id": 0 } // this is a projection - to include only 
    // assignment array
  )
    .sort({ "assignments.date": 1 })
    .limit(numberOfAssingments)
    .toArray()
}


const updateProfileImage = (id, new_image) => {
  return db.students.updateOne(
    { "_id": id },
    { $set: { "profileImage": new_image } }
  );
}
const updateProfileImageProfessors = (id, new_image) => {
  return db.professors.updateOne(
    { "_id": id },
    { $set: { "profileImage": new_image } }
  );
}

const addCourseToStudent = (id, new_course_id) => {
  return db.students.updateOne(
    { "_id": id },
    { $addToSet: { "courseId": new_course_id } }
  );
}

const addNewNotebook = (id, notebookId, new_file_url) => {
  return db.students.updateOne(
    { "_id": id, "notebooks._id": notebookId },
    { $addToSet: { "notebooks.$.fileURL": new_file_url } }
  );
}
const increaseCoursePoints = (id, pointsToIncrease) => {
  return db.courses.updateOne(
    { "_id": id },
    { $inc: { "points": pointsToIncrease } }
  );
}
const removeLastAssignment = (id) => {
  return db.students.updateOne(
    { "_id": id },
    { $pop: { "assignments": 1 } }
  );
}

const backupAndDeleteStudents = (year) => {
  const newCollectionName = `studentsBackup_${year}`;

  if (!db.getCollectionNames().includes(newCollectionName)) {
    db.createCollection(newCollectionName);
  }

  const startDate = ISODate(`${year}-01-01T00:00:00Z`);
  const endDate = ISODate(`${year}-12-31T23:59:59Z`);

  db.students.find({ "enrollmentDate": { $gte: startDate, $lte: endDate } })
    .forEach(function (doc) {
      db[newCollectionName].insertOne(doc);
    });

  db.students.deleteMany({ "enrollmentDate": { $gte: startDate, $lte: endDate } });
}


const getAccumulatedPointsPerStudent = () => {


  return db.marks.mapReduce(
    function () {
      // This is the map function
      var studentId = this.studentId;
      var coursePoints = {
        "50001": 3,  // Points for Introduction to Mathematics
        "50002": 4,  // Points for Physics 101
        "50003": 4,  // Points for Organic Chemistry
        "50004": 3,  // Points for Biology Basics
        "50005": 5   // Points for Introduction to Computer Science
      };

      // Iterate through semester A courses
      this.semesterA.forEach(function (course) {
        var courseId = course.courseId;
        var points = coursePoints[courseId] || 0;
        emit(studentId, { points: points });
      });

      // Iterate through semester B courses
      this.semesterB.forEach(function (course) {
        var courseId = course.courseId;
        var points = coursePoints[courseId] || 0;
        emit(studentId, { points: points });
      });
    },
    function (studentId, values) {
      // This is the reduce function
      return {
        totalPoints: values.reduce(function (acc, value) {
          return acc + value.points;
        }, 0)
      };
    },
    {
      // Output collection
      out: "studentTotalCredits"
    }
  );
}
