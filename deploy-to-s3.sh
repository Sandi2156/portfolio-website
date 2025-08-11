#!/bin/bash
# Usage: ./deploy-to-s3.sh <your-bucket-name> [aws-region]
# Example: ./deploy-to-s3.sh my-portfolio-bucket us-east-1

# configure you aws first using aws configure command

if [ -z "$1" ]; then
  echo "Error: S3 bucket name required."
  echo "Usage: $0 <bucket-name> [region]"
  exit 1
fi

BUCKET=$1
REGION=${2:-ap-south-1}


# Sync only assets/, website-demo-image/, and index.html
aws s3 sync . s3://$BUCKET/ \
  --region $REGION \
  --exclude "*" \
  --include "assets/*" \
  --include "website-demo-image/*" \
  --include "index.html" \
  --delete

if [ $? -eq 0 ]; then
  echo "Deployment to s3://$BUCKET/ successful."
else
  echo "Deployment failed. Check AWS CLI output for details."
fi

# Run this file - bash deploy-to-s3.sh <your-bucket-name> [aws-region]