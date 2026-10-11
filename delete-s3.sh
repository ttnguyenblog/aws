
#!/bin/bash

BUCKETS=(
  "aws-cicd-ec2-16"
  "cf-templates-14j4q3147gpds-ap-southeast-1"
  "cf-templates-1kczkvcrg4gzx-ap-southeast-1"
  "cf-templates-1kczkvcrg4gzx-us-east-1"
)

for BUCKET in "${BUCKETS[@]}"; do
  echo "======================================"
  echo "Deleting bucket: $BUCKET"

  aws s3 rm "s3://$BUCKET" --recursive
  if [ $? -ne 0 ]; then
    echo "WARNING: Failed to delete objects in $BUCKET"
    continue
  fi

  aws s3api delete-bucket --bucket "$BUCKET" --region ap-southeast-1
  if [ $? -eq 0 ]; then
    echo "SUCCESS: Deleted $BUCKET"
  else
    echo "WARNING: Could not delete $BUCKET"
  fi
done
