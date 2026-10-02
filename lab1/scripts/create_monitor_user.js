db = db.getSiblingDB("admin");

db.createUser({
  user: "mongodbMonitor",
  pwd: passwordPrompt(),
  roles: [
    { role: "clusterMonitor", db: "admin" },
    { role: "read", db: "local" }
  ]
});

print("mongodbMonitor user created successfully.");
