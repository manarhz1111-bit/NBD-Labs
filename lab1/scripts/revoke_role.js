db = db.getSiblingDB("university");

db.revokeRolesFromUser(
  "readerUser",
  [
    { role: "universityWriter", db: "university" }
  ]
);

print("Role universityWriter revoked from readerUser.");

printjson(db.getUser("readerUser"));
