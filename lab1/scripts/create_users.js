db = db.getSiblingDB("university");

if (db.getUser("readerUser") === null) {
  print("Creating readerUser. Enter a password:");
  db.createUser({
    user: "readerUser",
    pwd: passwordPrompt(),
    roles: [
      { role: "universityReader", db: "university" }
    ]
  });
  print("readerUser created successfully.");
} else {
  print("readerUser already exists.");
}

if (db.getUser("writerUser") === null) {
  print("Creating writerUser. Enter a password:");
  db.createUser({
    user: "writerUser",
    pwd: passwordPrompt(),
    roles: [
      { role: "universityWriter", db: "university" }
    ]
  });
  print("writerUser created successfully.");
} else {
  print("writerUser already exists.");
}

print("Users setup completed.");
