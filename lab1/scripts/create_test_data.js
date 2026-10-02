db = db.getSiblingDB("university");

db.students.updateOne(
  { _id: 1 },
  { $set: { name: "Alice", age: 21, major: "Computer Science" } },
  { upsert: true }
);

db.students.updateOne(
  { _id: 2 },
  { $set: { name: "Bob", age: 22, major: "Data Science" } },
  { upsert: true }
);

db.students.updateOne(
  { _id: 3 },
  { $set: { name: "Charlie", age: 20, major: "Software Engineering" } },
  { upsert: true }
);

db.courses.updateOne(
  { _id: 1 },
  { $set: { title: "Databases", credits: 5 } },
  { upsert: true }
);

db.courses.updateOne(
  { _id: 2 },
  { $set: { title: "Operating Systems", credits: 4 } },
  { upsert: true }
);

db.courses.updateOne(
  { _id: 3 },
  { $set: { title: "Computer Networks", credits: 4 } },
  { upsert: true }
);

db.grades.updateOne(
  { _id: 1 },
  { $set: { student_id: 1, course_id: 1, grade: 90 } },
  { upsert: true }
);

db.grades.updateOne(
  { _id: 2 },
  { $set: { student_id: 2, course_id: 1, grade: 85 } },
  { upsert: true }
);

db.grades.updateOne(
  { _id: 3 },
  { $set: { student_id: 3, course_id: 2, grade: 95 } },
  { upsert: true }
);

print("Training database created successfully.");
print("Collections:");
printjson(db.getCollectionNames());

print("Students count: " + db.students.countDocuments());
print("Courses count: " + db.courses.countDocuments());
print("Grades count: " + db.grades.countDocuments());
