db.students.insertMany([
    {
        "_id": "323456467",
        "firstName": "John",
        "lastName": "Doe",
        "address": {
            "city": "New York",
            "street": "5th Avenue",
            "number": "100"
        },
        "phone": "123-456-7890",
        "dateOfBirth": ISODate("2000-01-01T00:00:00Z"),
        "enrollmentDate": ISODate("2018-09-01T00:00:00Z"),
        "email": "john.doe@example.com",
        "profileImage": "profile_john_doe.jpg",
        "assignments": [
            {
                "assignmentId": "900001",
                "uploadedFile": "assignment1.pdf",
                "date": ISODate("2024-10-01T00:00:00Z"),
                "grade": 85
            }
        ],
        "notebooks": [
            {
                "_id": "900001",
                "course": "Mathematics",
                "lastUpdate": ISODate("2024-11-01T00:00:00Z"),
                "fileURL": ["notebook1.pdf"]
            }
        ],
        "coursIds": ["50001", "50002", "50003"]
    },
    {
        "_id": "654726784",
        "firstName": "Jane",
        "lastName": "Smith",
        "address": {
            "city": "Los Angeles",
            "street": "Sunset Blvd",
            "number": "200"
        },
        "phone": "987-654-3210",
        "dateOfBirth": ISODate("2001-02-15T00:00:00Z"),
        "enrollmentDate": ISODate("2024-09-01T00:00:00Z"),
        "email": "jane.smith@example.com",
        "profileImage": "profile_jane_smith.jpg",
        "assignments": [
            {
                "assignmentId": "900002",
                "uploadedFile": "assignment2.pdf",
                "date": ISODate("2024-10-05T00:00:00Z"),
                "grade": 92
            }
        ],
        "notebooks": [
            {
                "_id": "800002",
                "course": "Physics",
                "lastUpdate": ISODate("2024-11-10T00:00:00Z"),
                "fileURL": ["notebook2.pdf"]
            }
        ],
        "coursIds": ["50004", "50002", "50003"]
    },
    {
        "_id": "465837888",
        "firstName": "Mike",
        "lastName": "Johnson",
        "address": {
            "city": "Chicago",
            "street": "Lake Shore Drive",
            "number": "300"
        },
        "phone": "555-123-4567",
        "dateOfBirth": ISODate("1999-03-10T00:00:00Z"),
        "enrollmentDate": ISODate("2017-09-01T00:00:00Z"),
        "email": "mike.johnson@example.com",
        "profileImage": "profile_mike_johnson.jpg",
        "assignments": [
            {
                "assignmentId": "900003",
                "uploadedFile": "assignment3.pdf",
                "date": ISODate("2024-10-10T00:00:00Z"),
                "grade": 88
            }
        ],
        "notebooks": [
            {
                "_id": "800003",
                "course": "Chemistry",
                "lastUpdate": ISODate("2024-11-15T00:00:00Z"),
                "fileURL": ["notebook3.pdf"]
            }
        ],
        "coursIds": ["50001", "50005", "50003"]
    },
    {
        "_id": "364869364",
        "firstName": "Emily",
        "lastName": "Davis",
        "address": {
            "city": "Houston",
            "street": "Main Street",
            "number": "400"
        },
        "phone": "444-555-6666",
        "dateOfBirth": ISODate("2000-04-25T00:00:00Z"),
        "enrollmentDate": ISODate("2018-09-01T00:00:00Z"),
        "email": "emily.davis@example.com",
        "profileImage": "profile_emily_davis.jpg",
        "assignments": [
            {
                "assignmentId": "900004",
                "uploadedFile": "assignment4.pdf",
                "date": ISODate("2024-10-15T00:00:00Z"),
                "grade": 90
            }
        ],
        "notebooks": [
            {
                "_id": "800004",
                "course": "Biology",
                "lastUpdate": ISODate("2024-11-20T00:00:00Z"),
                "fileURL": ["notebook4.pdf"]
            }
        ],
        "coursIds": ["50001", "50004", "50005"]
    },
    {
        "_id": "246485638",
        "firstName": "David",
        "lastName": "Brown",
        "address": {
            "city": "Phoenix",
            "street": "Central Ave",
            "number": "500"
        },
        "phone": "333-777-8888",
        "dateOfBirth": ISODate("1998-05-20T00:00:00Z"),
        "enrollmentDate": ISODate("2016-09-01T00:00:00Z"),
        "email": "david.brown@example.com",
        "profileImage": "profile_david_brown.jpg",
        "assignments": [
            {
                "assignmentId": "900005",
                "uploadedFile": "assignment5.pdf",
                "date": ISODate("2024-10-20T00:00:00Z"),
                "grade": 87
            }
        ],
        "notebooks": [
            {
                "_id": "800005",
                "course": "Computer Science",
                "lastUpdate": ISODate("2024-11-25T00:00:00Z"),
                "fileURL": ["notebook5.pdf", "notebook6.pdf"]
            }
        ],
        "coursIds": ["50004", "50002", "50005"]
    }
]);




















db.professors.insertMany([
    {
        "id": "564790567",
        "firstName": "Alice",
        "lastName": "White",
        "address": {
            "city": "San Francisco",
            "street": "Market Street",
            "number": "600"
        },
        "phone": "111-222-3333",
        "dateOfBirth": ISODate("1975-06-15T00:00:00Z"),
        "occupationStart": ISODate("2005-08-01T00:00:00Z"),
        "educationLevel": "PhD",
        "email": "alice.white@example.com",
        "profileImage": "profile_alice_white.jpg",
        "currentCourses": [
            {
                "courseId": "50001",
                "year": 2023,
                "semester": "A"
            }
        ]
    },
    {
        "id": "567848679",
        "firstName": "Robert",
        "lastName": "Green",
        "address": {
            "city": "Seattle",
            "street": "Pine Street",
            "number": "700"
        },
        "phone": "444-555-6666",
        "dateOfBirth": ISODate("1980-07-10T00:00:00Z"),
        "occupationStart": ISODate("2010-09-01T00:00:00Z"),
        "educationLevel": "MSc",
        "email": "robert.green@example.com",
        "profileImage": "profile_robert_green.jpg",
        "currentCourses": [
            {
                "courseId": "50002",
                "year": 2023,
                "semester": "B"
            }
        ]
    },
    {
        "id": "564895560",
        "firstName": "Mary",
        "lastName": "Brown",
        "address": {
            "city": "Austin",
            "street": "Congress Ave",
            "number": "800"
        },
        "phone": "777-888-9999",
        "dateOfBirth": ISODate("1970-08-05T00:00:00Z"),
        "occupationStart": ISODate("2000-10-01T00:00:00Z"),
        "educationLevel": "PhD",
        "email": "mary.brown@example.com",
        "profileImage": "profile_mary_brown.jpg",
        "currentCourses": [
            {
                "courseId": "50003",
                "year": 2023,
                "semester": "A"
            }
        ]
    },
    {
        "id": "895475822",
        "firstName": "James",
        "lastName": "Taylor",
        "address": {
            "city": "Denver",
            "street": "16th Street",
            "number": "900"
        },
        "phone": "222-333-4444",
        "dateOfBirth": ISODate("1985-09-20T00:00:00Z"),
        "occupationStart": ISODate("2015-01-01T00:00:00Z"),
        "educationLevel": "MSc",
        "email": "james.taylor@example.com",
        "profileImage": "profile_james_taylor.jpg",
        "currentCourses": [
            {
                "courseId": "50004",
                "year": 2023,
                "semester": "B"
            }
        ]
    },
    {
        "id": "437789465",
        "firstName": "Patricia",
        "lastName": "Lee",
        "address": {
            "city": "Boston",
            "street": "Boylston Street",
            "number": "1000"
        },
        "phone": "555-666-7777",
        "dateOfBirth": ISODate("1990-10-30T00:00:00Z"),
        "occupationStart": ISODate("2020-03-01T00:00:00Z"),
        "educationLevel": "PhD",
        "email": "patricia.lee@example.com",
        "profileImage": "profile_patricia_lee.jpg",
        "currentCourses": [
            {
                "courseId": "50005",
                "year": 2023,
                "semester": "A"
            }
        ]
    }
]);























db.courses.insertMany([
    {
        "_id": "50001",
        "name": "Introduction to Mathematics",
        "points": 3,
        "field": "Mathematics"
    },
    {
        "_id": "50002",
        "name": "Physics 101",
        "points": 4,
        "field": "Physics"
    },
    {
        "_id": "50003",
        "name": "Organic Chemistry",
        "points": 4,
        "field": "Chemistry"
    },
    {
        "_id": "50004",
        "name": "Biology Basics",
        "points": 3,
        "field": "Biology"
    },
    {
        "_id": "50005",
        "name": "Introduction to Computer Science",
        "points": 5,
        "field": "Computer Science"
    }
]);













db.marks.insertMany([
    {
        "studentId": "123456789",
        "semesterA": [
            { "courseId": "50001", "grade": [85, 90] },
            { "courseId": "50002", "grade": [92, 88] },
            { "courseId": "50003", "grade": [78, 82] }
        ],
        "semesterB": [
            { "courseId": "50001", "grade": [80, 87] },
            { "courseId": "50002", "grade": [95, 91] },
            { "courseId": "50003", "grade": [84, 89] }
        ]
    },
    {
        "studentId": "987654321",
        "semesterA": [
            { "courseId": "50001", "grade": [75, 80] },
            { "courseId": "50002", "grade": [89, 93] },
            { "courseId": "50003", "grade": [86, 90] }
        ],
        "semesterB": [
            { "courseId": "50001", "grade": [82, 85] },
            { "courseId": "50002", "grade": [90, 94] },
            { "courseId": "50003", "grade": [91, 95] }
        ]
    },
    {
        "studentId": "456789123",
        "semesterA": [
            { "courseId": "50001", "grade": [88, 92] },
            { "courseId": "50002", "grade": [85, 90] },
            { "courseId": "50003", "grade": [79, 83] }
        ],
        "semesterB": [
            { "courseId": "50001", "grade": [83, 89] },
            { "courseId": "50002", "grade": [92, 96] },
            { "courseId": "50003", "grade": [86, 91] }
        ]
    },
    {
        "studentId": "789123456",
        "semesterA": [
            { "courseId": "50001", "grade": [90, 95] },
            { "courseId": "50002", "grade": [87, 91] },
            { "courseId": "50003", "grade": [82, 86] }
        ],
        "semesterB": [
            { "courseId": "50001", "grade": [87, 92] },
            { "courseId": "50002", "grade": [94, 98] },
            { "courseId": "50003", "grade": [89, 93] }
        ]
    },
    {
        "studentId": "234567890",
        "semesterA": [
            { "courseId": "50001", "grade": [78, 84] },
            { "courseId": "50002", "grade": [91, 95] },
            { "courseId": "50003", "grade": [84, 88] }
        ],
        "semesterB": [
            { "courseId": "50001", "grade": [84, 89] },
            { "courseId": "50002", "grade": [93, 97] },
            { "courseId": "50003", "grade": [88, 92] }
        ]
    }
]);













db.assignments.insertMany([
    {
        "_id": "90001",
        "courseId": "50001",
        "dueDate": ISODate("2024-12-01T00:00:00Z"),
        "requirements": "Solve the problem set.",
        "fileURL": "assignment1_instructions.pdf",
        "isListed": true
    },
    {
        "_id": "90002",
        "courseId": "50002",
        "dueDate": ISODate("2024-12-10T00:00:00Z"),
        "requirements": "Write a lab report.",
        "fileURL": "assignment2_instructions.pdf",
        "isListed": true
    },
    {
        "_id": "90003",
        "courseId": "50003",
        "dueDate": ISODate("2024-12-15T00:00:00Z"),
        "requirements": "Complete the reaction mechanisms.",
        "fileURL": "assignment3_instructions.pdf",
        "isListed": true
    },
    {
        "_id": "90004",
        "courseId": "50004",
        "dueDate": ISODate("2024-12-20T00:00:00Z"),
        "requirements": "Submit the biology essay.",
        "fileURL": "assignment4_instructions.pdf",
        "isListed": true
    },
    {
        "_id": "90005",
        "courseId": "50005",
        "dueDate": ISODate("2024-12-25T00:00:00Z"),
        "requirements": "Write a program in Python.",
        "fileURL": "assignment5_instructions.pdf",
        "isListed": false
    }
]);



