# neo4j indexex

In Neo4j, an index is a data structure that allows for efficient retrieval of nodes or relationships based on specific property values. Indexing is crucial for speeding up queries that involve searching for nodes or relationships with particular property values. Without an index, Neo4j would need to scan through all nodes or relationships in the database to find the ones that match the specified criteria, which can be inefficient for large datasets.

Neo4j supports several types of indexes, including:

1. **Node Indexes:** These indexes are used to speed up the retrieval of nodes based on the values of one or more of their properties. For example, you might create a node index on the "name" property of nodes representing people to quickly find a person by their name.

   ```cypher
   CREATE INDEX ON :Person(name);
   ```

2. **Relationship Indexes:** Similar to node indexes, these indexes are used for relationships and their properties.

   ```cypher
   CREATE INDEX ON :FRIENDS(since);
   ```

3. **Fulltext Indexes:** These indexes are used for searching for nodes based on the full text content of one or more of their properties.

   ```cypher
   CALL db.index.fulltext.createNodeIndex("textIndex",["Post"],["content"])
   ```

4. **Composite Indexes:** These indexes involve multiple properties and can be used to speed up queries that involve multiple criteria.

   ```cypher
   CREATE INDEX ON :Product(category, price);
   ```


## index renewal

Recreating indexes in Neo4j can serve several purposes, and the decision to recreate an index is often driven by specific use cases or database maintenance requirements. Here are some common reasons for recreating indexes in Neo4j:

1. **Schema Changes:** If you modify the schema of your graph, such as adding or removing properties from nodes or relationships, you may need to recreate indexes to reflect the changes. The structure of your indexes should align with the current structure of your graph to ensure optimal query performance.

   ```cypher
   DROP INDEX ON :Person(name);
   CREATE INDEX ON :Person(newPropertyName);
   ```

2. **Performance Optimization:** Over time, as your graph data evolves, the usage patterns of your queries may change. You might need to adjust or recreate indexes to better suit the new query patterns and improve overall performance.

   ```cypher
   DROP INDEX ON :Product(oldProperty);
   CREATE INDEX ON :Product(newProperty);
   ```

3. **Index Tuning:** Neo4j provides various types of indexes, and the choice of index type can impact query performance. Recreating indexes with different configurations or types might be done to fine-tune performance based on specific use cases or query requirements.

   ```cypher
   DROP INDEX ON :User(email);
   CREATE FULLTEXT INDEX ON :User(username);
   ```

4. **Rebuilding Corrupted Indexes:** In rare cases, indexes may become corrupted due to issues such as hardware failures or software bugs. Recreating indexes can help resolve corruption issues and restore the proper functioning of the index.

   ```cypher
   DROP INDEX ON :Product(price);
   CREATE INDEX ON :Product(price);
   ```

5. **Database Maintenance:** Periodic maintenance tasks, such as index rebuilding or defragmentation, may be necessary to optimize the storage and performance of your Neo4j database. Recreating indexes as part of routine maintenance can help keep the database in good health.

   ```cypher
   CALL db.index.fulltext.createNodeIndex("textIndex",["Post"],["content"]) YIELD name;
   CALL db.index.fulltext.dropIndex("textIndex");
   CALL db.index.fulltext.createNodeIndex(name,["Post"],["content"]);
   ```

Before recreating indexes, it's crucial to consider the potential impact on the overall system, especially in a production environment. Dropping and recreating indexes can temporarily affect query performance, and it's important to schedule such operations during maintenance windows or low-traffic periods.

## Sources :

- [official neo4j index documentation](https://neo4j.com/docs/cypher-manual/current/indexes/)
