import csv
import random
import argparse


def generate_random_marks(num_records: int, student_amount: int, course_amount: int) -> list:
    marks: list = []
    for _ in range(num_records):
        studentId = random.randint(1, student_amount)
        courseId = random.randint(1, course_amount)
        dateOps = [20210101, 20230101, 20240101]
        dateInd = random.randint(0, len(dateOps)-1)
        date = dateOps[dateInd]
        mark = random.randint(0, 100)
        semester = random.randint(1, 2)
        marks.append({
            'StudentId': studentId,
            'CourseId': courseId,
            'Date': date,
            'Mark': mark,
            'Semester': semester
        })
    return marks


def write_marks_to_csv(marks: list):
    with open("Marks.csv", 'w', newline='') as csvfile:
        fieldnames = ['StudentId', 'CourseId', 'Date', 'Mark', 'Semester']
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(marks)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Generate random data for the Marks table")
    parser.add_argument("num_records", type=int,
                        help="Number of records to generate")
    parser.add_argument("student_amount", type=int,
                        help="Maximum number of students")
    parser.add_argument("course_amount", type=int,
                        help="Maximum number of courses")
    args = parser.parse_args()

    marks = generate_random_marks(
        args.num_records, args.student_amount, args.course_amount)
    write_marks_to_csv(marks)
    print(
        f"Generated {args.num_records} records and saved to file Marks.csv")
