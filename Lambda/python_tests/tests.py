import unittest

from lambdafunction import Dynamodb_Resource, aws_region_name, dynamodb_table_name, dynamodb_table_key,dynamodb_table_value


class aws_connectivity(unittest.TestCase):
    def test_connection(self):
        #Create a DynamoDBResource
        connection = Dynamodb_Resource(aws_region_name,dynamodb_table_name,dynamodb_table_key,dynamodb_table_value)
        
        #Confirm the resource can successfully connect to AWS
        self.assertIsNotNone(connection.aws_resource)


test1 = aws_connectivity.test_connection()