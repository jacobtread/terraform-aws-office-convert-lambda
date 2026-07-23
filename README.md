# Office Convert Lambda

This terraform module sets up a AWS Lambda that uses https://github.com/jacobtread/office-convert-lambda to convert office files to PDF.

Includes the following created resources:

- Lambda (
    - Docker image based converter lambda
- ECR Repository
    - Private, required to host the docker image as lambdas cant be deployed from public images the image is pulled through from the public repository
- S3 Bucket
    - Bucket to store the input files and output files from the conversion process, files in this bucket expire after 1 day
