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
| BSON           | C++            | SSPL    | 8.2.6           |

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

BSON is JSON stored in a binary format for more efficiency. But this is only an implementation
detail, BSON objects themselves have the same syntax as JSON objects.

MongoDB is entirely schemaless, therefore documents inside the same collections don't have to
share any fields. This allows collections and their contained documents to be completely
dynamic and be adjusted individually.

## 3 Usage

MongoDB runs as a server and on port 27017 per default. Thereby it can only be used by
users that are registered inside the server and are authenticated. A root user is created
automatically on startup for which credentials can be set with the environment variables
`MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`.

MongoDB can be interacted with via the Mongo Shell in the terminal and via drivers in programms.
To connect to a running MongoDB server on the current machine via the Mongo Shell, the command
`mongosh` can be used.

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

{% endraw %}
