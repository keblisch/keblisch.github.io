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
- Official MongoDB repository: [mongodb/mongo](https://github.com/mongodb/mongo)
- Official MongoDB documentation: [MongoDB Documentation](https://www.mongodb.com/docs/)

## 2 Data Model

MongoDB operates on the following levels:

1. **Databases**: Encapsulates any number of collections
2. **Collections**: Contains any number of documents
3. **Documents**: Arbitrary BSON object

BSON is a superset of JSON that is stored in a binary format for more efficiency. It adds
additional syntax and data types,but also share the same syntax as JSON.

MongoDB is entirely schemaless, therefore documents inside the same collections don't have to
share any fields. This allows collections and their contained documents to be completely
dynamic and be adjusted individually. Because of this flexibility it's also common practice to
use embedded documents instead of joined collections in many places, to reduce complexity,
computation time and network load.

The only required field of documents are object id fields wth the identifier `_id`. This field is
automatically created and managed by MongoDB, but can be set manually. They`re used to uniquely
identify documents and operate on them, therefore they shouldn't be manipulated manually after
their creation.

Additionally the following restrictions exist for MongoDB:

- Documents can only be up to 16MB big
- Documents can only have a nesting level of up to 100 embedded documents

## 3 Usage

MongoDB runs as a server and on port 27017 per default. Thereby it can only be used by
users that are registered inside the server and are authenticated. A root user is created
automatically on startup for which credentials can be set with the environment variables
`MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`.

MongoDB holds a cache in RAM where it stores data that is operated upon in parallel to the actual
data stored on disk. Thereby operations are performed first on the cache, which is then
synchronized with the data on disk asynchronously. This removes the need for an additional
in-memory-cache in most cases.

### 3.1 Configuration

MongoDB can be started with the following arguments to configure the server that it's running:

| Flag        | Argument       | Description                                              |
| :---------- | :------------- | :------------------------------------------------------- |
| `--dbpath`  | Directory path | Sets the directory to store database files in            |
| `--logpath` | Directory path | Sets the directory to store log files in                 |
| `--fork`    | None           | Starts the server as a background process (only on Unix) |
| `--auth`    | None           | Starts the server as an user that needs to authenticate  |
| `--config`  | File path      | Sets a file to read additional configurations from       |

Configuration files for MongoDB are conventionally named `mongod.cfg` and look like the following:

```conf
# set directory to store database files in
storage:
    dbPath: "/data/db"

# set directory to store log files in
systemLog:
    destination: file
    path: "data/log"
```

### 3.2 MongoDB Shell

MongoDB can be interacted with via the MongoDB Shell (implemented in JavaScript and therefore
adhering to its rules) in the terminal. To connect to a running MongoDB server on the current
machine via the MongoDB Shell, the command `mongosh` can be used. Inside the shell command
completion with tab and command history with up are available.

```javascript
// exit the shell
exit

// clear the shell
cls

// get available commands
help                      // shell commands for regular user
help admin                // shell commands for admin user
db.help()                 // commands for current database
db.someCollection.help()  // commands for collection

// show all databases
show dbs

// show all collections in the current database
show collections

// switch to database (and create it when it doesn't exist)
use someDatabase

// delete current database
db.dropDatabase()

// show statistics about current database
db.stats()

// show execution plan and statistics for command
db.someCollection.explain().someCommand()

// shutdown MongoDB server
db.shutdownServer()
```

### 3.3 MongoDB Compass

MongoDB servers can be connected to with MongoDB Compass to have a graphical user interface. This
allows to do any operation from the MongoDB Shell in a GUI. It is available in a community version
with SSPL license, but also in a paid enterprise version with additional features.

### 3.4 Exchanging Data

Data from MongoDB databases can be exported and imported to share them across servers.

#### 3.4.1 Import Data

```bash
# import document from JSON file to collection
mongoimport path/to/file.json --db someDatabase --collection someCollection

# import array of documents from JSON file to collection
mongoimport path/to/file.json --db someDatabase --collection someCollection --jsonArray

# import JSON file into server with authentication
mongoimport path/to/file.json --db someDatabase --collection someCollection \
            --username name --password secret

# import JSON file to collection and delete it beforehand if it exists already
mongoimport path/to/file.json --db someDatabase --collection someCollection --drop
```

#### 3.4.2 Export Data

```bash
# export collection as array of document to JSON file
mongoexport --db someDatabase --collection someCollection --out path/to/file.json

# export JSON file from server with authentication
mongoexport --db someDatabase --collection someCollection --out path/to/file.json \
            --username name --password secret
```

#### 3.4.3 Execute Scripts

Because the MongoDB Shell is based on JavaScript, JavaScript can be executed inside it.

```bash
# execute JavaScript file in MongoDB server
mongo path/to/file.js
```

### 3.5 Hosting

The most popular way to deploy MongoDB is MongoDB Atlas, MongoDB's own managed cloud hosting
platform. It builds upon existing cloud hosting services and offers a seamless integration
between database development and deployment.

MongoDB can be configured to use replica sets. Thereby multiple instances of MongoDB are run
(that may run across different machines) where one acts as the primary node of the cluster.
Data is copied from the primary node to every other node to create exact replicas, so that
a secondary node can take over when the primary node dies or isn't available. Additionally,
reading operations can be split between nodes to enhance their speed.

There exists the option of Sharding for MongoDB servers. Thereby multiple MongoDB servers
(called shards) are run in a cluster on different machines to horizontally scale. For this
the data and operations are split across the cluster's servers and a central router (`mongos`)
orchestrates the communication to and between these.

## 4 Data Types

The following data types are used by BSON:

| Data Type    | Implementation / Meaning              | Example                                |
| :----------- | :------------------------------------ | :------------------------------------- |
| `int`        | 32-bit signed integer                 | `42`                                   |
| `long`       | 64-bit signed integer                 | `Long("426743287")`                    |
| `double`     | 64-bit floating-point number          | `3.14`                                 |
| `decimal128` | 128-bit decimal floating-point number | `Decimal128("3.14")`                   |
| `bool`       | Boolean value                         | `true`, `false`                        |
| `string`     | UTF-8 string                          | `"Hello, World"`                       |
| `regex`      | Regular expression                    | `/^[A-Za-z0-9]+$/`                     |
| `array`      | Ordered list of values                | `[1, 2, 3]`                            |
| `object`     | Embedded document / key-value pairs   | `{"name": "John", "age": 21}`          |
| `objectId`   | 12-byte unique identifier             | `ObjectId("64f1c2a9b8e7d6c5f4a3b2c1")` |
| `date`       | UTC datetime                          | `new Date()`                           |
| `binData`    | Binary data                           |                                        |
| `null`       | Null value                            | `null`                                 |

Because the MongoDB Shell is based on JavaScript, all values are treated as JavaScript types per
default and have to be explicitly constructed if this is undesired.

```javascript
// string
{ value: "Hello" }

// int
{ value: NumberInt(42) }

// long
{ value: NumberLong("426743287") }

// double
{ value: 3.14 }

// decimal128
{ value: NumberDecimal("3.14") }

// bool
{ value: true }
{ value: false }

// null
{ value: null }

// object / embedded document
{ value: {"name": "John", "age": 21} }

// array
{ value: [1, 2, 3] }

// objectId
{ value: ObjectId("64f1c2a9b8e7d6c5f4a3b2c1") }

// date
{ value: new Date() }
{ value: new Date("2000-12-31") }

// regex
{ value: /^[A-Za-z0-9]+$/ }

// binary data
{ value: BinData(0, "SGVsbG8=") }
```

## 5 Variables

Inside of MongoDB Shell sessions values and results can be stored in variables to reuse them
later.

```javascript
// store result of expression in variable
var firstName = db.people.findOne().name

// store result of operation in variable
var person = db.people.findOne()

// use variable in operation
db.people.find({"name": firstName})
```

## 6 Control Flow Structures

Inside of MongoDB Shell sessions control flow structures can be used.

```javascript
// loop certain amount of times
for (int i = 0; i < 10; i++) {
    db.people.findOne()
}
```

## 7 Functions

Predefined functions can be used to interact with data inside MongoDB.

```javascript
// pretty print document as JSON
printjson({"name": "John", "age": 21})
```

## 8 CRUD Operations

Every CRUD operation returns a response object in the form of an array or document containing
data related to the operation.

CRUD operations are atomic on a document basis, meaning that every operation on single documents
is rolled backed when it failed or was interrupted. But when an error or interruption occurs in
an operation on multiple documents, the operation isn't rolled back for documents that were
successful.

To perform operations MongoDB follows an execution plan which picks the most optimal way to
perform this operation automatically. To deduce this execution plan different approaches are
performed in parallel and the first operation reaching the so called winning goal is the
winning plan and is picked as the according execution plan. The result of that test is cached
and only rerun after a certain amount of time or multiple updates to the effected collections.

### 8.1 Create Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `insertedId`: An object Id from the created document (when only one document was created)
- `insertedIds`: An array of object IDs from the created documents
                 (when multiple documents where created)

```javascript
// create collection
db.createCollection("people")

// create collection capped collection (clears oldest document when maximum is reached)
db.createCollection("people", {
    "capped": true,  // make collection capped
    "size": 256,     // maximum number of bytes (4 per default)
    "max": 8         // maximum number of documents (optional)
})

// insert new document into collection (and create collection when it doesn't exist)
db.people.insertOne({"name": "John", "age": 21})

// insert new documents into collection (and create collection when it doesn't exist)
db.people.insertMany([{"name": "John", "age": 21}, {"name": "Jane", "age": 18}])

// insert new documents without stopping the operation when an insertion failed
db.people.insertMany(
    [{"name": "John", "age": 21}, {"name": "Jane", "age": 18}], {"ordered": false},
)

// only acknowledge document insertion when it has been written to memory (default)
db.people.insertOne({"name": "John", "age": 21}, {"writeConcern": {"w: 1"}})

// only acknowledge document insertion when it has been journald to disk
db.people.insertOne({"name": "John", "age": 21}, {"writeConcern": {"w": 1, "j": true}})

// don't await any acknowledgement of document insertion
db.people.insertOne({"name": "John", "age": 21}, {"writeConcern": {"w": 0}})
```

### 8.2 Read Operations

Response objects of read operations are either single documents or cursor objects to multiple
documents. Thereby cursor objects act like pointers to result sets to be more performant in case
of large amounts of data, but act like arrays in most cases.

```javascript
db.people.insertMany([
    {"name": "John", "age": 21, "height": 1.8, "hobbies": ["Hiking", "Chess"],},
    {"name": "Jane", "age": 18, "height": 1.75, "hobbies": ["Jogging", "Reading"]},
])

// get all documents from collection
db.people.find()

// get all documents from collection that contain specified fields
db.people.find({"name": "John"})

// get first document from collection that contain specified fields
db.people.findOne({"name": "John"})

// get documents from collection that fulfill specified query operator
db.people.find({"$age": {"$gt": 18}})              // single operator
db.people.find({"$age": {"$gt": 18, "$ne": 100}})  // multiple operators

// get documents from collection that fulfill logically chained query operators
db.people.find({"$or": [{"$age": {"$gt": 12}}, {"$age": {"$lt": 18}}]})

// get documents from collection that contain specified array elements
db.people.find({"hobbies": "Hiking"})             // match for single element
db.people.find({"hobbies": ["Hiking", "Chess"]})  // match for entire array

// get documents from collection with only their projected fields
db.people.find({"name": "John"}, {"name": 1})            // only include fields with an assigned 1
db.people.find({"name": "John"}, {"name": 1, "_id": 0})  // exclude fields with an assigned 0
db.people.find({}, {"age": {"$gt": 18}})             // include fields that fulfill query operator
db.people.find({}, {"hobbies": {"$slice": 2}})       // include sliced array field
db.people.find({}, {"hobbies": {"$slice": [1, 2]}})  // include sliced array field with offset

// sort found documents by specified fields
db.people.find().sort({"age": 1})                // in ascending order
db.people.find().sort({"age": -1})               // in descending order
db.people.find().sort({"age": 1, "height": -1})  // by multiple fields

// limit number of found documents
db.people.find().limit(10)

// skip number of found documents
db.people.find().skip(10)

// get number of found documents
db.people.find().count()

// pretty print found documents of cursor object
db.people.find().pretty()

// get entire result set of cursor object as array
db.people.find().toArray()

// get next document from result set of cursor object
var result = db.people.find()
result.next()

// check if there is a next document in result set of cursor object
result = db.people.find()
result.hasNext()

// iterate over every document from result set of cursor object
db.people.find().forEach((person) => {printjson(person)})
```

The following query operators are available:

| Operator      | Meaning                                                         |
| :------------ | :-------------------------------------------------------------- |
| `$eq`         | Field should equal specified value                              |
| `$ne`         | Field shouldn't equal specified value                           |
| `$gt`         | Field should be greater than specified value                    |
| `$gte`        | Field should be greater than or equal specified value           |
| `$lt`         | Field should be less than specified value                       |
| `$lte`        | Field should be less than or equal specified value              |
| `$in`         | Field should be in specified array                              |
| `$nin`        | Field shouldn't be in specified array                           |
| `$all`        | Array field should include specified array                      |
| `$elemMatch`  | Array field's elements should fulfill specified query operator  |
| `$size`       | Array field should be of specified size                         |
| `$regex`      | Field should match specified regular expression                 |
| `$exists`     | Whether Field should exist according to boolean                 |
| `$type`       | Field should have specified data type as string                 |
| `$type`       | Field should have any data type in specified array              |

The following logical operators are available:

| Operator      | Meaning                                                         |
| :------------ | :-------------------------------------------------------------- |
| `$or`         | Field should fulfill any specified query operator               |
| `$nor`        | Field shouldn't fulfill any specified query operator            |
| `$and`        | Field should fulfill every specified query operator             |
| `$not`        | Invert effect of query operator or logical operator             |

### 8.3 Update Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `matchedCount`: An integer containing the number of documents matched by the query
- `modifiedCount`: An integer containing the number of updated documents
- `upsertedId`: An object Id from the created document when one document was upserted
- `upsertedIds`: An array of object IDs from the created documents
                 when multiple documents where upserted

To query documents to update the same syntax as in read operations can be used.

```javascript
db.people.insertMany([
    {"name": "John", "age": 21, "hobbies": ["Hiking", "Chess"],},
    {"name": "Jane", "age": 18, "hobbies": ["Jogging", "Reading"]},
])

// update first document in collection that matches query with specified set operator
db.people.updateOne({"name": "John"}, {"$set": {"name": "Johnny"}})

// update all documents in collection that matches query with specified set operator
db.people.updateMany({"age": 21}, {"$set": {"age": 18}})

// update documents in collection that matches query or create them if they don't exist
db.people.updateMany({"age": 21}, {"$set": {"age": 18}}, {"upsert": true})

// update all array elements of field in document that matches query
db.people.updateMany({"name": "John"}, {"$set": {"hobbies.$[]": "Climbing"}})

// update array elements in document that matches query
db.people.updateMany({"elemMatch": {"$eq": "Hiking"}}, {"$set": {"hobbies.$": "Climbing"}})

// replace first document in collection that matches query with specified fields
db.people.replaceOne({"name": "John"}, {"name": "Johnny"})

// replace all documents in collection that matches query with specified fields
db.people.replaceMany({"age": 21}, {"name": "Johnny"})
```

The following update operators are available:

| Operator      | Meaning                                                         |
| :------------ | :-------------------------------------------------------------- |
| `$set`        | Set Field to specified value                                    |
| `$min`        | Set Field to specified value if it is higher than the field     |
| `$max`        | Set Field to specified value if it is lower than the field      |
| `$inc`        | Increment field by specified amount                             |
| `$mul`        | Multiply field by specified amount                              |
| `$rename`     | Rename field by specified string                                |
| `$unset`      | Remove used field (value is irrelevant)                         |
| `$push`       | Push value or values of `$each` operator to array field         |
| `$addToSet`   | Push value or to array field if doesn't exist already           |
| `$each`       | Provide elements of specified array to `$push` operator         |
| `$pull`       | Remove specified value from array field                         |
| `$pop`        | Remove last value from array field if value is 1 or first if -1 |

### 8.4 Delete Operations

Every response object of delete operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `deleteCount`: An integer containing the number of deleted documents

To query documents to delete the same syntax as in read operations can be used.

```javascript
db.people.insertMany([
    {"name": "John", "age": 21, "hobbies": ["Hiking", "Chess"],},
    {"name": "Jane", "age": 18, "hobbies": ["Jogging", "Reading"]},
])

// delete first document in collection that matches query
db.people.deleteOne({"name": "John"})

// delete all documents in collection that matches query
db.people.deleteMany({"age": 21})

// delete every document in collection
db.people.deleteMany({})

// delete database
db.dropDatabase()

// delete collection
db.people.drop()
```

### 8.5 Transactions

Transactions enable sequences of operations to be atomic, this means that the entire sequence
is rolled back when one of it's operations failed. Thereby transactions are only available for
MongoDB clusters which use replica sets or sharding.

```javascript
// create session for transaction
const session = db.getMongo().startSession()

// start transaction
session.startTransaction()

// bind collection to transaction
const myCollection = session.getDatabases("contacts").people

// define operations for transaction that don't get executed yet
myCollection.insertOne({"name": "John", "age": 21})
myCollection.deleteOne({"name": "John"})

// execute transaction and delete it afterwards
session.commitTransaction()

// abort and delete transaction
session.abortTransaction()
```

## 9 Aggregations

Aggregations are used to manipulate collections for display in pipelines of operations. Thereby
they're also used to join collections that have a one-to-many or many-to-many relationship.
Their result objects are either single documents or arrays of documents.

```javascript
db.people.insertOne({"name": "John", "age": 21, "hobbyIds": [
    ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), ObjectId("64f1c2a9b8e7d6c5f4a3b2c2")
]})
db.hobbies.insertMany([
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), "name": "Jogging"},
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c2"), "name": "Reading"}
])

// search collection with query operation (returns cursor object)
db.people.aggregate([{"$match": {"name": "John", {"age": {"$gt": 18}}}}])

// group documents by specified fields
db.people.aggregate([{"$group": {
   "_id": {"personName": "$name"},  // define fields by which to group and create field for it
   "total": {"$sum": 1}             // operation to perform on group and create field for it
}}])

// create document for each element of specified array and give it one as the field's value
db.people.aggregate([{"$unwind": "hobbyIds"}])

// sort collection by specified fields
db.people.aggregate([{"$sort": {"age": 1}}])

// limit number of documents in collection
db.people.aggregate([{"$limit": 10}])

// skip number of documents in collection
db.people.aggregate([{"$skip": 10}])

// project documents into specified fields
db.people.aggregate([{"$project": {"name": 1, "_id": 0}}])
db.people.aggregate([{"$project": {
    "age2": "$age"                              // reference other field in projection
}}])
db.people.aggregate([{"$project": {
    "greet": {"$concat": ["Hi", " ", "$name"]}  // create value/field for projection
}}])
db.people.aggregate([{"$project": {
    "name": {"$toUpper": "$name"}               // perform field manipulation for projection
}}])

// merge documents from other collection into documents of specified collection
db.people.aggregate([{"$lookup": {
    "from": "hobbies",         // other collection to aggregate from
    "localField": "hobbyIds",  // field containing values in other collection to match
    "foreignField": "_id",     // field in other collection to match
    "as": "hobbyData"          // name of field to insert results in
}}])

// chain aggregation operations into pipeline where each step takes output of last step as input
db.people.aggregate([
    {"$match": {"name": "John", {"age": {"$gt": 18}}}},
    {"$group": {"_id": {"personName": "$name"}, "total": {"$sum": 1}}},
    {"$sort": {"total": -1}},
    {"$limit": 10},
    {"$project": {"_id": 0, "total": 1}}
])

// save aggregation output to collection and replace it when it already exists
db.people.aggregate([{"$out": "otherPeople"}])
```

The following group operators are available:

| Operator    | Meaning                                                                          |
| :---------- | :------------------------------------------------------------------------------- |
| `$sum`      | Sum specified value/field of entire group                                        |
| `$avg`      | Calculate average of specified value/field of entire group                       |
| `$min`      | Get smallest value/field of entire group                                         |
| `$max`      | Get largest value/field of entire group                                          |
| `$push`     | Push specified value/field to array for entire group                             |
| `$addToSet` | Push specified value/field to array for entire group if it doesn't exist already |

## 10 Indices

Indices are indexing collections by their document's fields to speed up lookup and sort operations
for these. But this comes at the cost of larger disk consumption and a small performance penalty
for operations that modify the collection, because its index also has to be modified.

Indexes can consist of single fields or be built from multiple fields. Thereby compound indices
from multiple fields can act as indices of single fields if only the first value in the compound
index is looked up.

Additionally, there exists a default index for all documents of a collection that indexes them
by their object ID. This is index is entirely managed by MongoDB itself and therefore shouldn't
be manipulated.

The following additional restrictions do exist for indexes:

- Only the top level fields of embedded documents are going to be indexed
- Compound indices can only contain up to one array

```javascript
db.people.insertMany([
    {"name": "John", "age": 21, "hobbies": ["Hiking", "Chess"], "createdAt": new Date()},
    {"name": "Jane", "age": 18, "hobbies": ["Jogging", "Reading"], "createdAt": new Date()},
])

// get array of documents describing all existing indices
db.people.getIndexes()

// create index for single field of collection
db.people.createIndex({"name": 1})  // in ascending order
db.people.createIndex({"age": -1})  // in descending order

// create compound index from multiple fields of collection
db.people.createIndex({"name": 1, "age": 1})   // in ascending order
db.people.createIndex({"name": 1, "age": -1})  // with descending order

// create text index that normalizes text for querying (faster than RegEx)
db.people.createIndex({"name": "text"})
db.people.createIndex(
    {"name": "text"},
    {"defaultLanguage": "german"},                  // specify language for entire index
)
db.people.createIndex(
    {"name": "text"},
    {"languageOverride": "language"},               // set field to specify document's language
)
db.people.createIndex(
    {"name": "text"},
    {"weights": {"name": 10}},                      // specify relative weights for indexed fields
)
db.people.find({"$text": {"$search": "john"}})      // search for indexed text
db.people.find({"$text": {"$search": "john -ny"}})  // exclude words in search
db.people.find(
    {"$text": {"$search": "john"}},
    {"$language": "german"},                        // set search language in case of multiple
)
db.people.find(
    {"$text": {"$search": "john"}},
    {"$meta": "score"},                             // sort by matching score and add it as field
)

// delete index for field of collection
dp.people.dropIndex({"name": 1})

// create index in the background to not block operations on collection
db.people.createIndex({"name": 1}, {"background": true})

// create index which must consist of unique values (and to enforce unqie values in collections)
db.people.createIndex({"name": 1}, {"unique": true})
db.people.createIndex({"name": 1, "age": -1}, {"unique": true})

// create partial index that only indexes collections that match filter
// (collection scans are performed as a fallback for partial indices)
db.people.createIndex({"name": 1}, {"partialFilterExpression": {"age": {"$gt: 18}}})
db.people.createIndex({"name": 1, "age": -1}, {"partialFilterExpression": {"age": {"$gt: 18}}})

// create time-to-live (TTL) index that deletes indexed document after certain amount of time
// (indexed field must be of type date)
db.people.createIndex({"createdAt": 1}, {"expireAfterSeconds": 600})
```

## 11 Schema Validation

Even though MongoDB doesn't enforce schemas, documents can be validated at runtime to adhere
to a minimum set of requirements.

```javascript
// create collection with validator for all its documents
db.createCollection("people", {"validator": {
    "$jsonSchema": {
        "bsonType": "object",                                      // define type of documents
        "required": ["name", "age"],                               // define fields of document
        "properties": {                                            // define field's requirements
            "name": {
                "bsonType": "string",                              // define type of field
                "description": "Is required and must be a string"  // description for requirement
            },
            "hobbies": {
                "bsonType": "array",                               // define type of field
                "description": "Must be an array",                 // description for requirement
                "items": {                                         // define elements of array
                    "bsonType": "object",                          // define element as document
                    "required": ["name"],
                    "properties": {
                        "name": {
                            "bsonType": "string"
                        }
                    }
                }
            }
        }
    },
    "validationAction": "error"    // throw error on validation failure (default)
    //"validationAction": "warn"   // show warning on validation failure
}})

// update schema validation for collection
db.runCommand({"collMod": "people", {"validator": {
    "$jsonSchema": {
        "bsonType": "object",
        "required": ["name", "height"],
    }
}}})
```

## 12 Geospatial Data

Geospatial data is represented by documents in the GeoJSON format. The following types of GeoJSON
objects do exist:

```json
// single coordinate (longitude, latitude)
{"type": "point", "coordinates": [45, 30]}

// polygon of coordinates (longitude, latitude)
{"type": "Polygon", "coordinates": [
    [[45, 30], [50, 20], [65, 10]]
]}
```

```javascript
// create location data
db.places.insertOne({
    "name" "My Place",
    "location": {"type": "point", "coordinates": [45, 30]}
})

// create index of geospatial data field (required for most geospatial operations)
db.places.createIndex({"location": "2dsphere"})

// get array of documents with near location
db.places.find({"location": {
    "$near": {"$geometry": {"type": "point", "coordinates": [45, 30]}}}
})
db.places.find({"location": {  // define how near point should be
    "$near": {"$geometry": {"type": "point", "coordinates": [45, 30]}},
    "$minDistance": 10,  // in meters
    "$maxDistance": 30   // in meters
}})

// get array of documents with location inside radius
db.places.find({"location": {
    "$geoWithin": {"$centerSphere": [[45, 30], 5]}  // center and radius in kilometers
}})

// get array of documents with location inside polygon
db.places.find({"location": {
    "$geoWithin": {
        "$geometry": {
            "type": "Polygon", "coordinates": [
                [[45, 30], [50, 20], [65, 10]]
            ]
        }
    }}
})

// get whether point/polygon intersects with polygon
db.places.find({"location": {
    "$geoIntersects": {
        "$geometry": {
            "type": "Point", "coordinates": [45, 30]
        }
    }}
})
db.places.find({"location": {
    "$geoIntersects": {
        "$geometry": {
            "type": "Polygon", "coordinates": [
                [[45, 30], [50, 20], [65, 10]]
            ]
        }
    }}
})
```

## 13 User Management

In MongoDB actions need to be performed by registered users that are authorized for these actions
on specific databases. Users are stored in a database and have roles assigned that describe which
permissions they have on their assigned databases. Thereby a root user exists per default which
has every role.

```bash
# start MongoDB as authenticated user
mongo --user john --password mySecretPassword --authenticationDatabase admin
```

```javascript
// create user in current database and give it roles assigned to that database
use admin
db.createUser({"user": "john", "pwd": "mySecretPassword", "roles": [
    "readWrite",                      // assign role for user's database
    {"role": "read", "db": "people"}  // assign role for specific database
]})

// update user
db.updateUser("john", {
    "pwd": "newSecretPassword",  // update password
    "roles": [                                 // replace roles
        "read",                                // assign role for user's database
        {"role": "readWrite", "db": "people"}  // assign role for specific database
    ]
})

// authenticate as user in current database
db.auth("john", "mySecretPassword")

// logout as user
db.logout()

// get description of user
db.getUser("john")
```

The following roles do exist:

| Role                   | Permission                                                    |
| :--------------------- | :------------------------------------------------------------ |
| `root`                 | All permissions for all databases                             |
| `read`                 | Any read operation on collections for the database            |
| `readWrite`            | Any read and write operation on collections for the database  |
| `dbAdmin`              | Editing the database itself                                   |
| `userAdmin`            | Creating, editing and deleting users for the database         |
| `dbOwner`              | All permissions for the database                              |
| `readAnyDatabase`      | Any read operation on collections for all databases           |
| `readWriteAnyDatabase` | Any read and write operation on collections for all databases |
| `dbAdminAnyDatabase`   | Editing all databases                                         |
| `userAdminAnyDatabase` | Creating, editing and deleting users for all databases        |

{% endraw %}
