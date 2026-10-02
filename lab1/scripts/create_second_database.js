db = db.getSiblingDB("research");

db.projects.updateOne(
  { _id: 1 },
  { $set: { name: "NoSQL Study", status: "active" } },
  { upsert: true }
);

db.projects.updateOne(
  { _id: 2 },
  { $set: { name: "MongoDB Monitoring", status: "active" } },
  { upsert: true }
);

db.results.updateOne(
  { _id: 1 },
  { $set: { project_id: 1, value: 95 } },
  { upsert: true }
);

print("Second training database created successfully.");
print("Collections:");
printjson(db.getCollectionNames());
