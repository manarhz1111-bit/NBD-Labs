db = db.getSiblingDB("university");

const userDeleted = db.dropUser("studentsUser");
print("studentsUser deleted: " + userDeleted);

const roleDeleted = db.dropRole("studentsOnlyReader");
print("studentsOnlyReader deleted: " + roleDeleted);

print("Cleanup completed.");
