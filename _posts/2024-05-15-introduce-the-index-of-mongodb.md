---
layout: post
title: 'Introduce the Index of MongoDB'
date: '2024-05-17'
author: Nick Yang
tags:
- MongoDB
- Indexes
---

## What are indexes for

The primary function of indexes is to improve the performance of queries and update/sort operations. For instance, when searching for all pages in a book containing a certain word or phrase, you can refer to the index to quickly locate the associated page numbers. The index provides a quick way to find the information you need without having to read the entire book.

Similarly, a MongoDB index stores a small portion of the data set in an easy-to-traverse form. Without indexes, the database engine must scan every document in a collection to return query results. This can be slow and resource-intensive, especially for large collections.

## Prefix Compression

Index prefix compression deduplicates common prefixes in a compound index. It can reduce memory and disk space requirements for indexes. MongoDB uses prefix compression on all indexes, including single-key indexes.

![prefix encoding](https://devopedia.org/images/article/159/6930.1553271271.jpg)

ref: [https://devopedia.org/database-compression](https://devopedia.org/database-compression)

## Misconceptions

### MongoDB is so fast that it doesn't need indexes

MongoDB is fast, but it's not magic. Indexes are still important for performance. Without indexes, MongoDB must perform a collection scan.

> **INFO** The query is fast enough if the data is less than 10,000 records.

### Every field is automatically indexed

MongoDB automatically creates an index on the `_id` field. You can also create indexes on other fields to improve query performance. Not all fields are indexed by default, so it is essential to create indexes on fields you query often.

In an ideal scenario, all fields would be indexed, but this can consume a lot of memory and disk space while also slowing down write operations. It's important to balance the benefits of indexing with the costs.

> **HINT** Up to 64 indexes per collection is allowed. 4 indexes per collection is a good rule of thumb.

### NoSQL uses hashes instead of indexes

NoSQL databases like MongoDB use indexes to improve query performance.

## Index Types

MongoDB provides several types of indexes to support specific types of queries and data models. Indexes can be created on any field in a document, including fields within arrays. MongoDB provides the following types of indexes:

- Single Field
- Multikey
- Compound
- Text
- Hashed
- ...

### Single Field

 Single Field indexes store information from a single field in a collection. By default, MongoDB creates a unique index on the `_id` field in every collection. You can also create single field indexes on other fields in a collection to speed up important queries and operations.

#### Create a Single Field Index

```javascript
db.<collection>.createIndex( { <field>: <sortOrder> } )
```

> **HINT** `sortOrder` can be either `1` for ascending or `-1` for descending.

### Multikey

Multikey indexes are indexes on arrays. When you create an index on a field that contains an array value, MongoDB automatically creates a multikey index. If an array field contains multiple instances of the same value, the index will store the value only once.

#### Create a Multikey Index

```javascript
db.<collection>.createIndex( { <arrayField>: <sortOrder> } )
```

### Compound

Compound indexes index from two or more fields in each document in a collection. This is the most common index type in MongoDB. While it is often to use 3 or 4 fields in a compound index, MongoDB supports up to 32 fields in a compound index. It is similar to a single field index, but it can improve query performance for queries that use multiple fields. It is important to note that the order of the fields in a compound index matters.

#### Create a Compound Index

```javascript
db.<collection>.createIndex( { 
    <field1>: <sortOrder1>,
    <field2>: <sortOrder2> 
} )
```

#### ESR Principle

The ESR principle is a good rule of thumb for creating compound indexes. It stands for Equality, Sort, and Range. When creating a compound index, you should consider the following:

- **Equality**: Fields that are used in equality queries should come first in the index.
- **Sort**: Fields that are used in sort queries should come next in the index.
- **Range**: Fields that are used in range queries should come last in the index.

> Example:
> We want to query Alice's lastest month's login records.
> 1st. it should match the user name, Alice.
> 2nd. it should sort the records by the login time.
> 3th. it should find the records in the lastest month.

### Text

Text indexes support full-text search of string content. Text indexes can include any field whose value is a string or an array of string elements.

#### Create a Text Index

```javascript
db.<collection>.createIndex( { 
    <field1>: "text 1",
    <field2>: "text 2", 
} )
```

### Hashed

Hashed indexes index a 20 byte md5 of the BSON value. It can potentially reduce index size if original values are large.

> **DOWNSIDE** radom values in a BTree use excessive resources.

#### Create a Hashed Index

```javascript
db.<collection>.createIndex( { <field>: "hashed" } )
```

## Performance

Indexes can improve read performance when used. However, each index adds ~10% overhead to write (insert, delete, update) operations. (Hashed indexes, multikey indexes, text indexes, and wildcard indexes can add more overhead.)

### `explain()`

The `explain()` method provides information on the query plan and index usage. You can use the `explain()` method to analyze query performance and optimize indexes.

#### Example

```javascript
db.<collection>.find( { <query> } ).explain('executionStats')
```

## Use Indexes with Care

- **Use Indexes to Support Queries**: Indexes can improve query performance, but they can also slow down write operations. Use indexes to support queries that are important to your application.
- **Avoid Over-Indexing**: Indexes consume memory and disk space. Avoid creating indexes on fields that are rarely queried.
- **Monitor Index Usage**: Use the `explain()` method to monitor index usage and query performance. Optimize indexes based on query performance.

## References

- [Indexes](https://docs.mongodb.com/manual/indexes/)
- [What is indexing in a Database](https://www.mongodb.com/resources/basics/databases/database-index)
- [Database Compression](https://devopedia.org/database-compression)
- [Prefix Code](https://www.sciencedirect.com/topics/mathematics/prefix-code#:~:text=In%20other%20words%2C%20a%20prefix,bits%20to%20a%20shorter%20codeword.)
- [explain()](https://www.mongodb.com/docs/manual/reference/command/explain/)
