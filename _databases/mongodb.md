---
layout: base
title: MongoDB
---

<!-- markdownlint-disable MD013 MD033 MD032 MD029 MD025 MD022 MD007 -->

{% raw %}

# MongoDB
{: .no_toc }

MongoDB is a document based No-SQL database that is build to handle large amounts of data in
asynchronous environments.

| Query Language | Implementation | License | Current Version |
| :------------- | :------------- | :------ | :-------------- |
| BSON           | C++            | SSPL    | 8.2.7           |

## Table of Contents
{: .no_toc .text-delta }

- TOC
{:toc}

## 1 Resources

- Official MongoDB website: [MongoDB](https://www.mongodb.com/)

## 2 Data Model

MongoDB operates on the following levels:

1. **Databases**: Encapsulates any number of collections
2. **Collections**: Contains any number of documents
3. **Documents**: Arbitrary BSON object

BSON is a superset of JSON that is stored in a binary format for more efficiency. It adds
additional syntax and data types,but also share the same syntax as JSON.

MongoDB is entirely schemaless, therefore documents inside the same collections don't have to
share any fields. This allows collections and their contained documents to be completely
dynamic and be adjusted individually.

The only required field of documents are object id fields wth the identifier `_id`. This field is
automatically created and managed by MongoDB, but can be set manually. They`re used to uniquely
identify documents and operate on them, therefore they shouldn't be manipulated manually after
their creation.

## 3 Usage

MongoDB runs as a server and on port 27017 per default. Thereby it can only be used by
users that are registered inside the server and are authenticated. A root user is created
automatically on startup for which credentials can be set with the environment variables
`MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`.

MongoDB can be interacted with via the Mongo Shell in the terminal and via drivers in programs.
To connect to a running MongoDB server on the current machine via the Mongo Shell, the command
`mongosh` can be used. Inside the shell command completion with tab and command history with
up are available.

```bash
# exit the shell
exit

# clear the shell
cls

# show all Databases
show dbs

# switch to database (and create it when it doesn't exist)
use someDatabase
```

Additionally the following restrictions exist for MongoDB:

- Documents can only be up to 16MB big
- Documents can only have a nesting level of up to 100 embedded documents

## 4 CRUD Operations

Every CRUD operation returns a response object in the form of an array or document containing
data related to the operation.

### 4.1 Create Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `insertedId`: An object Is from the created document (when only one document was created)
- `insertedIds`: An array of object IDs from the created documents
                 (when multiple documents where created)

```mongodb
// insert new document into collection (and create collection when it doesn't exist)
db.people.insertOne({name: "John", age: 21})

// insert new documents into collection (and create collection when it doesn't exist)
db.people.insertMany([{name: "John", age: 21}, {name: "Jane", age: 18}])
```

### 4.2 Read Operations

Response objects of read operations are either single documents or cursor objects to multiple
documents. Thereby cursor objects act like pointers to result sets to be more performant in case
of large amounts of data, but act like arrays in most cases.

```mongodb
// get all documents from collection
db.people.find()

// get all documents from collection that contain specified fields
db.people.find({name: "John"})

// get first document from collection that contain specified fields
db.people.findOne({name: "John"})

// get documents from collection that fulfill specified filter
db.people.find({$gt: {age: 18}})

// get documents from collection with only their projected fields
db.people.find({name: "John"}, {name: 1})          // only include fields with an assigned 1
db.people.find({name: "John"}, {name: 1, _id: 0})  // explicitly exclude fields with an assigned 0

// get document from collection by its ID
db.people.findOne({_id: ObjectId(123456789abcdefghi)})

// pretty print found documents of cursor object
db.people.find().pretty()

// get entire result set of cursor object as array
db.people.find().toArray()

// iterate over every document from result set of cursor object
db.people.find().forEach((person) => {printjson(person)})
```

### 4.3 Update Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `matchedCount`: An integer containing the number of documents matched by the query
- `modifiedCount`: An integer containing the number of updated documents

```mongodb
// update first document in collection that contains specified fields with specified set operator
db.people.updateOne({name: "John"}, {$set: {name: "Johnny"}})

// update all documents in collection that contain specified fields with specified set operator
db.people.updateMany({age: 21}, {$set: {age: 18}})

// replace first document in collection that contains specified fields with specified fields
db.people.replaceOne({name: "John"}, {name: "Johnny"})

// replace all documents in collection that contain specified fields with specified fields
db.people.replaceMany({age: 21}, {name: "Johnny"})

// update documents in collection that fulfill specified filter
db.people.updateMany({$gt: {age: 18}}, {$set: {age: 16}})
db.people.replaceMany({$gt: {age: 18}},{name: "Jay" })

// update document in collection by its ID
db.people.updateOne({_id: ObjectId(123456789abcdefghi)}, {$set: {name: "Johnny"})
```

### 4.4 Delete Operations

Every response object of delete operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `deleteCount`: An integer containing the number of deleted documents

```mongodb
// delete first document in collection that contains specified fields
db.people.deleteOne({name: "John"})

// delete all documents in collection that contain specified fields
db.people.deleteMany({age: 21})

// delete entire collection
db.people.deleteMany({})

// delete documents in collection that fulfill specified filter
db.people.find({$gt: {age: 18}})

// delete document in collection by its ID
db.people.updateOne({_id: ObjectId(123456789abcdefghi)})
```

{% endraw %}

## 5 Operators

Operators a predefined fields that are used to declare operations on documents to MongoDB.

```mongodb
// use operator as filter
db.people.find({$gt: {age: 18}})

// use operator as command to manipulate document
db.people.updateOne({name: "John"}, {$set: {name: "Johnny"}})
```

| Operator | Usage                                                         | Example             |
| :------- | :------------------------------------------------------------ | :------------------ |
| `$gt`    | Filter specified field to be greater than its specified value | `{$gt: {num: 18}}`  |
| `$set`   | Set specified field to its specified value                    | `{$set: {val: 18}}` |

## 6 Functions

Predefined functions can be used to interact with data inside MongoDB.

```mongodb
// pretty print document as JSON
printjson({name: "John", age: 21})
```
