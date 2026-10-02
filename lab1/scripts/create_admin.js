db = db.getSiblingDB("admin");

db.createUser({
  user: "labAdmin",
  pwd: passwordPrompt(),
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" }
  ]
});

print("Admin user labAdmin created successfully.");
