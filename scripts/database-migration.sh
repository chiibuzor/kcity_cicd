#!/bin/bash
set -e

echo "Running database migrations on Aurora cluster..."
aws rds-data execute-statement \
    --resource-arn arn:aws:rds:global-db-identifier \
    --secret-arn arn:aws:secretsmanager:your-secret \
    --database database_name \
    --sql "ALTER TABLE example ADD COLUMN new_column VARCHAR(255);"
