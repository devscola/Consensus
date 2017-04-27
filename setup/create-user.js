db.createUser(
{
    user: "consensus",
    pwd: "consensus",
    roles: [
      { role: "readWrite", db: "consensus_db" }
    ]
});