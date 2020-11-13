const { CosmosClient } = require("@azure/cosmos");
 
const endpoint = "https://localhost:8081";
const key = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
const client = new CosmosClient({ endpoint, key });
 
async function main() {
  const { database } = await client.databases.createIfNotExists({ id: "Test Database" });
  console.log(database.id);
}
 
main().catch((error) => {
  console.error(error);
});
