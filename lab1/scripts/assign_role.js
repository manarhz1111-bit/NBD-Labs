db = db.getSiblingDB("university");

db.grantRolesToUser(
  "readerUser",
  [
    { role: "universityWriter", db: "university" }
  ]
);

print("Role universityWriter assigned to readerUser.");

printjson(db.getUser("readerUser"));
