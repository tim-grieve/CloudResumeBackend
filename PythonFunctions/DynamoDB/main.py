import boto3
from botocore.config import Config

client_config = Config(
    region_name = 'ca-central-1',
    signature_version = 'v4',
    retries = {
        'max_attempts': 10,
        'mode': 'standard'
    }
)

dynamodb = boto3.resource('dynamodb', config=client_config)

table = dynamodb.Table('visitor_counter')

count = table.get_item(
    Key={
        "SiteName": "Resume"
    }
)
new_count = (count['Item']['Count']) + 1

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
)
    

    
