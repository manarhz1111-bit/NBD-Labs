db = db.getSiblingDB("university");

db.createRole({
  role: "universityReader",
  privileges: [
    {
      resource: { db: "university", collection: "" },
      actions: ["find"]
    }
  ],
  roles: []
});

db.createRole({
  role: "universityWriter",
  privileges: [
    {
      resource: { db: "university", collection: "" },
      actions: ["find", "insert", "update"]
    }
  ],
  roles: []
});

print("Custom roles created successfully.");
print("Created roles: universityReader, universityWriter");
