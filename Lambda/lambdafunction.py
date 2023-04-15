import json
import boto3

aws_region_name = 'ca-central-1'
dynamodb_table_key = "SiteName"
dynamodb_table_value = "Resume"
dynamodb_table_name = "visitor_counter"

class AWS_Resource:
    def __init__(self,resource_type,region_name):
        self.resource_type = resource_type
        self.region_name = region_name
        self.aws_resource = self.connect()
        
    def connect(self):
        return boto3.resource(self.resource_type, region_name = self.region_name)
    
class Dynamodb_Resource(AWS_Resource):
    def __init__(self,region_name, table_name,table_key,table_value): 
        resource_type = 'dynamodb'
        super().__init__(resource_type,region_name)
        self.dynamodb_table = self.table(table_name = table_name)
        self.table_key = table_key
        self.table_value = table_value

    def table(self,table_name):
        return self.aws_resource.Table(table_name)
        
    def get_count(self):
        return self.dynamodb_table.get_item(
            key ={
                f"{self.table_key}" : f"{self.table_value}" 
            }
        )
    
    def update_count(self,new_count):
        self.dynamodb_table.update_item(
            Key ={
                f"{self.table_key}": f"{self.table_value}"
            },
            UpdateExpression ="set #Count = :c",
            ExpressionAttributeNames={
                '#Count': 'Count'
            },
            ExpressionAttributeValues={
                ':c':new_count
            }
        )

    def increment_count(self):
        table_item = self.get_count()
        new_count = (table_item['Item']['Count']) + 1
        self.update_count(new_count=new_count)
        return_item = {
            "count": str(new_count)
        }
        return return_item


def lambda_handler(event, context):
   dynamodb = Dynamodb_Resource(aws_region_name,dynamodb_table_name,dynamodb_table_key,dynamodb_table_value)

   return_item = dynamodb.increment_count()
   
   ''' dynamodb = boto3.resource('dynamodb', region_name = aws_region_name)

    table = dynamodb.Table('visitor_counter')

    count = table.get_item(
        Key={
            "SiteName": "Resume"
        }
    )
    new_count = (count['Item']['Count']) + 1

    return_item = {
        "count": str(new_count)
    }

    response = table.update_item(
        Key ={
            'SiteName': 'Resume'
        },
        UpdateExpression ="set #Count = :c",
        ExpressionAttributeNames={
            '#Count': 'Count'
        },
        ExpressionAttributeValues={
            ':c':new_count
        }
    ) '''
   
   return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps(return_item)
    }
