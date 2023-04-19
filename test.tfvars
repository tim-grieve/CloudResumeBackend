provider_region_id = "ca-central-1"
lambda_function_name = "ResumeSiteCounter_test"
lambda_role_permission_sid1 = "VisualEditor0"
lambda_role_permission_sid2 = "VisualEditor1"
lambda_role_permission_sid3 = "VisualEditor2"
lambda_role_permission_type = "Service"
lambda_service_identifier = "lambda.amazonaws.com"
lambda_iam_role_name = "test_iam_for_lambda"
lambda_iam_policy_name = "test_resume_lambda_policy"
lambda_python_source_file = "./Lambda/lambdafunction.py"
lambda_archive_output_path = "./Lambda/lambda_function_payload.zip"
lambda_function_handler_name = "lambdafunction.lambda_handler"
lambda_runtime_version = "python3.9"
dynamodb_table_name = "test_visitor_counter"
dynamodb_table_billingmode = "PAY_PER_REQUEST"
dynamodb_table_hashkey = "SiteName"
dynamodb_table_attribute_name = "SiteName"
dynamodb_attribute_type = "S"
dynamodb_table_ttl_attribute_name = "TimeToExist"
dynamodb_table_ttl_attribute_enabled = false
dynamodb_table_tag_name = "Name"
dynamodb_table_tag_value = "Resume Visitor Counter"
dynamodb_initial_value_sitename = "Resume"
apigateway_name = "resume-counter-api_test"