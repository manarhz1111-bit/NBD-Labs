db = db.getSiblingDB("university");

db.createRole({
  role: "studentsOnlyReader",
  privileges: [
    {
      resource: { db: "university", collection: "students" },
      actions: ["find"]
    }
  ],
  roles: []
});

print("Role studentsOnlyReader created successfully.");
