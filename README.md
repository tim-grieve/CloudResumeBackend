# CloudResumeBackend

## Description
This project provides a backend for the Cloud Resume Website https://github.com/tim-grieve/CloudResumeWebsite inspired by Forest Brazeal's Cloud Resume Challenge https://cloudresumechallenge.dev/docs/the-challenge/ the backend maintains a count of the visitors to the from end website via and AWS APIGATEWAY http api. The back end utilises AWS APIGateway, Dynamodb and Lambda services to calculate, store and send the count details.

## Components
### Lambda
The Lambda function utilises a python script to query the count value stored in dynamo db and also increment the count value by 1 every time the function is called. The python function also returns the headers required to meet the cors security standard.

### Dynamodb
A dynamodb table is used to store the visitor count from the website.

### APIGateway
The api gateway serves as the connection between the frontend website and the back end services. It is deployed as an http gateway which calls the Lambda function each time a request is recieved.

## Deployment
### Terraform
All of the components and deployed via terraform IAC.

### GitHub Actions
All changes are committed to the test branch of the repo which triggers a git hub action to perform a series of tests including unit tests for the Lambda python code and a test deployment of the terraform code to ensure success. On successful completion of the test work flow a pull request is issued to merge the changes into the main branch. When the changes are merged into the main branch a second  workflow is triggered which deploys any changes to production.

## Areas for improvement
### Python tests
Some more testing around edge cases would be benifical.
### Make the visitor counter smarter
The visitor count currently increments by 1 each time the function is called. This could be improved to find a count of unique visitors only.
### Seperate the lambada zip file creation into a seperate step 
Independent of the main terraform code so that it can be called seperately from the test and main branch commits

