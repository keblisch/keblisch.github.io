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

### 3.1 Configuration

MongoDB can be started with the following arguments to configure the server that it's running:

| Flag        | Argument       | Description                                              |
| :---------- | :------------- | :------------------------------------------------------- |
| `--dbpath`  | Directory path | Sets the directory to store database files in            |
| `--logpath` | Directory path | Sets the directory to store log files in                 |
| `--fork`    | None           | Starts the server as a background process (only on Unix) |
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

```bash
# exit the shell
exit

# clear the shell
cls

# get available commands
help                      # shell commands for regular user
help admin                # shell commands for admin user
db.help()                 # commands for current database
db.someCollection.help()  # commands for collection

# show all databases
show dbs

# show all collections in the current database
show collections

# switch to database (and create it when it doesn't exist)
use someDatabase

# delete current database
db.dropDatabase()

# show statistics about current database
db.stats()

# shutdown MongoDB server
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

## 4 Data Types

MongoDB implements its own data types that are based on JSON, but also adds additional data types.

| Data Type          | Implementation                     | Example                 |
| :----------------- | :--------------------------------- | :---------------------- |
| `String`           | String of any number of characters | `"Hello!"`              |
| `Boolean`          | Boolean true and false             | `true`, `false`         |
| `Number`           | Any numerical value                | `4`, `3.14`             |
| `NumberInt`        | 32 bit integer                     | `2374`                  |
| `NumberLong`       | 64 bit integer                     | `100000000000`          |
| `NumberDecimal`    | 64 bit floating point number       | `3.14`                  |
| `Object`           | Documents as elements of documents | `Timestamp(123456789)`  |
| `Array`            | Arbitrary list of values           | `Timestamp(123456789)`  |
| `ObjectId`         | Unique id based on Unix time       | `ObjectId("1234abcd")`  |
| `ISODate`          | Date according to ISO norm         | `ISODate("2000-12-31")` |
| `Timestamp`        | Unix timestamp                     | `Timestamp(123456789)`  |

```javascript
// explicitly set data type of numbers
NumberInt(142)
NumberLong(12.78)
NumberDecimal(1.45)

// create timestamp
new Timestamp()
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

## 6 Functions

Predefined functions can be used to interact with data inside MongoDB.

```javascript
// pretty print document as JSON
printjson({"name": "John", "age": 21})
```

## 7 Operators

Operators are predefined fields that are used to declare operations inside a database. Thereby
they're used in different contexts with according meanings.

| Operator      | Type                 | Meaning                                                         |
| :------------ | :------------------- | :-------------------------------------------------------------- |
| `$eq`         | Query operator       | Field should equal specified value                              |
| `$ne`         | Query operator       | Field shouldn't equal specified value                           |
| `$gt`         | Query operator       | Field should be greater than specified value                    |
| `$gte`        | Query operator       | Field should be greater than or equal specified value           |
| `$lt`         | Query operator       | Field should be less than specified value                       |
| `$lte`        | Query operator       | Field should be less than or equal specified value              |
| `$in`         | Query operator       | Field should be in specified array                              |
| `$nin`        | Query operator       | Field shouldn't be in specified array                           |
| `$all`        | Query operator       | Array field should include specified array                      |
| `$elemMatch`  | Query operator       | Array field's elements should fulfill specified query operator  |
| `$size`       | Query operator       | Array field should be of specified size                         |
| `$regex`      | Query operator       | Field should match specified regular expression                 |
| `$expr`       | Query operator       | Field should match specified expression syntax                  |
| `$exists`     | Query operator       | Whether Field should exist according to boolean                 |
| `$type`       | Query operator       | Field should have specified data type as string                 |
| `$type`       | Query operator       | Field should have any data type in specified array              |
| `$or`         | Logical operator     | Field should fulfill any specified query operator               |
| `$nor`        | Logical operator     | Field shouldn't fulfill any specified query operator            |
| `$and`        | Logical operator     | Field should fulfill every specified query operator             |
| `$not`        | Logical operator     | Invert effect of query operator or logical operator             |
| `$slice`      | Projection operator  | Projected field should only contain number of elements          |
| `$set`        | Update operator      | Set Field to specified value                                    |
| `$min`        | Update operator      | Set Field to specified value if it is higher than the field     |
| `$max`        | Update operator      | Set Field to specified value if it is lower than the field      |
| `$inc`        | Update operator      | Increment field by specified amount                             |
| `$mul`        | Update operator      | Multiply field by specified amount                              |
| `$rename`     | Update operator      | Rename field by specified string                                |
| `$unset`      | Update operator      | Remove used field (value is irrelevant)                         |
| `$push`       | Update operator      | Push value or values of `$each` operator to array field         |
| `$addToSet`   | Update operator      | Push value or to array field if doesn't exist already           |
| `$each`       | Update operator      | Provide elements of specified array to `$push` operator         |
| `$pull`       | Update operator      | Remove specified value from array field                         |
| `$pop`        | Update operator      | Remove last value from array field if value is 1 or first if -1 |
| `$lookup`     | Aggregation operator | Aggregate documents from different collections                  |
| `$jsonSchema` | Evaluation operator  | Documents must adhere to specified schema at creation           |

```javascript
db.people.insertOne({"name": "John", "hobbyIds": [
    ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), ObjectId("64f1c2a9b8e7d6c5f4a3b2c2")
]})
db.hobbies.insertMany([
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), "name": "Jogging"},
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c2"), "name": "Reading"}
])

// use query operator
db.people.find({"$age": {"$gt": 18}})              // single operator
db.people.find({"$age": {"$gt": 18, "$ne": 100}})  // multiple operators

// chain query operators with logical operator
db.people.find({"$or": [{"$age": {"$gt": 12}}, {"$age": {"$lt": 18}}]})

// use projection operator
db.people.find({}, {"hobbyIds": {"$slice": 2}})

// use update operator
db.people.updateOne({"name": "John"}, {"$set": {"name": "Johnny"}})

// use aggregation operator
db.people.aggregate([{"$lookup": {
    "from": "hobbies",
    "localField": "hobbyIds",
    "foreignField": "_id",
    "as": "hobbyData"
}}])

// use evaluation operator
db.createCollection("people", {"validator": {
    "$jsonSchema": {
        "bsonType": "object",
        "required": ["name", "height"],
    }
}})
```

## 8 CRUD Operations

Every CRUD operation returns a response object in the form of an array or document containing
data related to the operation.

CRUD operations are atomic on a document basis, meaning that every operation on single documents
is rolled backed when it failed or was interrupted. But when an error or interruption occurs in
an operation on multiple documents, the operation isn't rolled back for documents that were
successful,

### 8.1 Create Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `insertedId`: An object Id from the created document (when only one document was created)
- `insertedIds`: An array of object IDs from the created documents
                 (when multiple documents where created)

```javascript
// create collection
db.createCollection("people")

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

## 9 Aggregations

Aggregations can be used to join collections that have a one-to-many or many-to-many relationship.
Their result objects are either single documents or arrays of documents.

```javascript
db.people.insertOne({"name": "John", "hobbyIds": [
    ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), ObjectId("64f1c2a9b8e7d6c5f4a3b2c2")
]})
db.hobbies.insertMany([
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), "name": "Jogging"},
    {"_id": ObjectId("64f1c2a9b8e7d6c5f4a3b2c2"), "name": "Reading"}
])

// aggregate documents from other collection into documents of specified collection
db.people.aggregate([{"$lookup": {
    "from": "hobbies",         // other collection to aggregate from
    "localField": "hobbyIds",  // field containing values in other collection to match
    "foreignField": "_id",     // field in other collection to match
    "as": "hobbyData"          // name of field to insert results in
}}])
```

## 10 Schema Validation

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

{% endraw %}
