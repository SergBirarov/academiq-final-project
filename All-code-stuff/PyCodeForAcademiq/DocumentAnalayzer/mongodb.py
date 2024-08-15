import os
from pymongo import MongoClient, InsertOne, DeleteOne, ReplaceOne
from pymongo.errors import PyMongoError
from dotenv import load_dotenv


class MongoDBManager:
    def __init__(self, connection_string=None, database_name=None, collection=None):
        load_dotenv()
        if not connection_string:
            connection_string = os.getenv('MONGO_SERVER')

        self.client = MongoClient(connection_string)
        self.db = self.client[database_name] if database_name else None
        self.collection = self.db[collection] if collection else None

    def set_database(self, database_name):
        self.db = self.client[database_name]

    def set_collection(self, collection_name):
        self.collection = self.db[collection_name]

    def insert_one(self, document):
        return self.collection.insert_one(document)

    def insert_many(self, documents):
        return self.collection.insert_many(documents)

    def find_one(self, query):
        return self.collection.find_one(query)

    def find_all(self, query=None):
        return self.collection.find(query or {})

    def update_one(self, query, new_values, upsert=False):
        return self.collection.update_one(query, {"$set": new_values}, upsert=upsert)

    def update_many(self, query, new_values, upsert=False):
        return self.collection.update_many(query, {"$set": new_values}, upsert=upsert)

    def delete_one(self, query):
        return self.collection.delete_one(query)

    def delete_many(self, query):
        return self.collection.delete_many(query)


