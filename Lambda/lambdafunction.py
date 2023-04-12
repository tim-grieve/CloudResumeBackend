import json
import boto3

def lambda_handler(event, context):
    dynamodb = boto3.resource('dynamodb', region_name = 'ca-central-1')

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
    )
    return {
        'statusCode': 200,
        'body': json.dumps(return_item)
    }
