db = db.getSiblingDB("university");

db.createUser({
  user: "studentsUser",
  pwd: passwordPrompt(),
  roles: [
    { role: "studentsOnlyReader", db: "university" }
  ]
});

print("studentsUser created successfully.");
