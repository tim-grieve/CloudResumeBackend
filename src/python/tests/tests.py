import unittest
import decimal

from aws_lambda.lambda_function import Dynamodb_Resource, aws_region_name, dynamodb_table_name, dynamodb_table_key, dynamodb_table_value


class AwsConnectivity(unittest.TestCase):
    def test_connection(self):
        # Create a DynamoDBResource
        connection = Dynamodb_Resource(aws_region_name,dynamodb_table_name,dynamodb_table_key,dynamodb_table_value)
        # Confirm the resource can successfully connect to AWS
        self.assertIsNotNone(connection.aws_resource, 'Connection to dynamodb failed')

    def test_count_value(self):
        connection = Dynamodb_Resource(aws_region_name, dynamodb_table_name, dynamodb_table_key, dynamodb_table_value)
        count = connection.get_count()['Item']['Count']

        self.assertIsInstance(count, decimal.Decimal, 'Count is not a Decimal')

    def test_increment_count(self):
        connection = Dynamodb_Resource(aws_region_name, dynamodb_table_name, dynamodb_table_key, dynamodb_table_value)
        count = connection.get_count()['Item']['Count']
        new_count = connection.increment_count()
        self.assertTrue(new_count - count == 1, "Count not incrementing by 1")

tests = AwsConnectivity()

tests.test_connection()
tests.test_count_value()
tests.test_increment_count()

print(aws_region_name)