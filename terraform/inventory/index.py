          import os
          import boto3
          import urllib.request
          import json
          import cfnresponse
          from urllib.parse import urlparse

          s3 = boto3.resource('s3')

          def save_to_local(url):
            urlPath = urlparse(url).path
            fileName = os.path.basename(urlPath)
            filePath = '/tmp/' + fileName
            urllib.request.urlretrieve(url, filePath)
            return filePath
            
          def upload_to_s3(filePath, bucket):
            fileName = os.path.basename(filePath)
            s3.Bucket(bucket).upload_file(filePath, fileName) 
            

          def copy_to_s3(url, bucket):
            filePath = save_to_local(url)
            upload_to_s3(filePath, bucket)

          def lambda_handler(event, context):
            properties = event['ResourceProperties']
            urls = properties['Urls']
            bucket = properties['S3BucketName']
            try:
              for url in urls:
                print(url)
                copy_to_s3(url, bucket)
                
            except Exception as e:
              print(e)
              responseData = {}
              responseData['Data'] = "Failure"
              cfnresponse.send(event, context, cfnresponse.FAILED,responseData, "CustomResourcePhysicalID")
              return
            responseData = {}
            responseData['Data'] = "Success"
            cfnresponse.send(event, context, cfnresponse.SUCCESS,responseData, "CustomResourcePhysicalID")