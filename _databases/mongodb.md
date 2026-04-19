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

### 3.2 Mongo Shell

MongoDB can be interacted with via the Mongo Shell (implemented in JavaScript and therefore
adhering to its rules) in the terminal. To connect to a running MongoDB server on the current
machine via the Mongo Shell, the command `mongosh` can be used. Inside the shell command
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

## 4 CRUD Operations

Every CRUD operation returns a response object in the form of an array or document containing
data related to the operation.

### 4.1 Create Operations

Every response object of update operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `insertedId`: An object Is from the created document (when only one document was created)
- `insertedIds`: An array of object IDs from the created documents
                 (when multiple documents where created)

```javascript
// create collection
db.createCollection("people")

// insert new document into collection (and create collection when it doesn't exist)
db.people.insertOne({name: "John", age: 21})

// insert new documents into collection (and create collection when it doesn't exist)
db.people.insertMany([{name: "John", age: 21}, {name: "Jane", age: 18}])
```

### 4.2 Read Operations

Response objects of read operations are either single documents or cursor objects to multiple
documents. Thereby cursor objects act like pointers to result sets to be more performant in case
of large amounts of data, but act like arrays in most cases.

```javascript
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

```javascript
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
```

### 4.4 Delete Operations

Every response object of delete operations contain the following fields:

- `acknowledged`: A boolean that signals whether the operation was successful
- `deleteCount`: An integer containing the number of deleted documents

```javascript
// delete first document in collection that contains specified fields
db.people.deleteOne({name: "John"})

// delete all documents in collection that contain specified fields
db.people.deleteMany({age: 21})

// delete every document in collection
db.people.deleteMany({})

// delete documents in collection that fulfill specified filter
db.people.find({$gt: {age: 18}})

// delete database
db.dropDatabase()

// delete collection
db.people.drop()
```

## 5 Aggregations

Aggregations can be used to join collections that have a one-to-many or many-to-many relationship.
Their result objects are either single documents or arrays of documents.

```javascript
db.people.insertOne({name: "John", hobbyIds: [
    ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), ObjectId("64f1c2a9b8e7d6c5f4a3b2c2")
]})
db.hobbies.insertMany([
    {_id: ObjectId("64f1c2a9b8e7d6c5f4a3b2c1"), name: "Jogging"},
    {_id: ObjectId("64f1c2a9b8e7d6c5f4a3b2c2"), name: "Reading"}
])

// aggregate documents from other collection into documents of specified collection
db.people.aggregate([{$lookup: {
    from: "hobbies",         // other collection to aggregate from
    localField: "hobbyIds",  // field containing values in other collection to match
    foreignField: "_id",     // field in other collection to match
    as: "hobbyData"          // name of field to insert results in
}}])
```

## 6 Schema Validation

Even though MongoDB doesn't enforce schemas, documents can be validated at runtime to adhere
to a minimum set of requirements.

```javascript
// create collection with validator for all its documents
db.createCollection("people", {validator: {
    $jsonSchema: {
        bsonType: "object",                                      // define type of documents
        required: ["name", "age"],                               // define fields of document
        properties: {                                            // define requirements for fields
            name: {
                bsonType: "string",                              // define type of field
                description: "Is required and must be a string"  // description for requirement
            },
            hobbies: {
                bsonType: "array",                               // define type of field
                description: "Must be an array",                 // description for requirement
                items: {                                         // define elements of array
                    bsonType: "object",                          // define element as document
                    required: ["name"],
                    properties: {
                        name: {
                            bsonType: "string"
                        }
                    }
                }
            }
        }
    },
    validationAction: "error"    // throw error on validation failure (default)
    //validationAction: "warn"   // show warning on validation failure
}})

// update schema validation for collection
db.runCommand({collMod: "people", {validator: {
    $jsonSchema: {
        bsonType: "object",
        required: ["name", "height"],
    }
}}})
```

## 7 Data Types

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

## 8 Variables

Inside of Mongo Shell sessions values and results can be stored in variables to reuse them later.

```javascript
// store result of expression in variable
var firstName = db.people.findOne().name

// store result of operation in variable
var person = db-people.findOne()

// use variable in operation
db.people.find({name: firstName})
```

## 9 Functions

Predefined functions can be used to interact with data inside MongoDB.

```javascript
// pretty print document as JSON
printjson({name: "John", age: 21})
```

## 10 Operators

Operators a predefined fields that are used to declare operations on documents in CRUD operations.

```javascript
// use operator as filter
db.people.find({$gt: {age: 18}})

// use operator as command to manipulate document
db.people.updateOne({name: "John"}, {$set: {name: "Johnny"}})
```

| Operator | Usage                                                         | Example             |
| :------- | :------------------------------------------------------------ | :------------------ |
| `$gt`    | Filter specified field to be greater than its specified value | `{$gt: {num: 18}}`  |
| `$set`   | Set specified field to its specified value                    | `{$set: {val: 18}}` |

{% endraw %}
