const { CosmosClient } = require("@azure/cosmos");
 
const endpoint = "https://localhost:8081";
const key = "C2y6yDjf5/R+ob0N8A7Cgv30VRDJIWEHLM+4QDU5DE2nQ9nDuVTqobD4b8mGGyPMbIZnqyMsEcaGQy67XIw/Jw==";
const client = new CosmosClient({ endpoint, key });
 
async function main() {
  const { database } = await client.databases.createIfNotExists({ id: "Test Database" });
  console.log("created database", database.id);
 
  const { container } = await database.containers.createIfNotExists({ id: "Test Container" });
  console.log("created container", container.id);
 
  const cities = [
    { id: "1", name: "Olympia", state: "WA", isCapitol: true },
    { id: "2", name: "Redmond", state: "WA", isCapitol: false },
    { id: "3", name: "Chicago", state: "IL", isCapitol: false }
  ];
  for (const city of cities) {
    await container.items.create(city);
  }
  console.log("inserted records into container");
 
  const querySpec = {
    query: "SELECT * from c"
  };

  // read all items in the Items container
  const { resources: items } = await container.items
    .query(querySpec)
    .fetchAll();

  items.forEach(item => {
    console.log(`${item.id} - ${item.description}`);
  });
}
 
main().catch((error) => {
  console.error(error);
});
