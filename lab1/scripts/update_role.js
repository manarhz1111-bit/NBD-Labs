db = db.getSiblingDB("university");

db.updateRole(
  "universityReader",
  {
    privileges: [
      {
        resource: { db: "university", collection: "" },
        actions: ["find", "listCollections"]
      }
    ],
    roles: []
  }
);

print("Role universityReader updated successfully.");
printjson(db.getRole("universityReader", { showPrivileges: true }));
