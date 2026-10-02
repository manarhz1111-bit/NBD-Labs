db = db.getSiblingDB("university");

const loadCollection = db.getCollection("load_test");

print("=== Starting MongoDB load test ===");
print("Generating inserts, reads and updates for 180 seconds...");

for (let second = 1; second <= 180; second++) {

  for (let i = 0; i < 300; i++) {

    const id = "load-" + Date.now() + "-" + second + "-" + i;

    // INSERT
    loadCollection.insertOne({
      _id: id,
      value: i,
      createdAt: new Date()
    });

    // READ
    loadCollection.findOne({ _id: id });

    // UPDATE
    loadCollection.updateOne(
      { _id: id },
      { $inc: { value: 1 } }
    );
  }

  if (second % 10 === 0) {
    print("Load running... " + second + "/180 seconds");
  }

  sleep(1000);
}

print("=== Load test completed ===");
print("Documents in load_test: " + loadCollection.countDocuments());
