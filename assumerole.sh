#!/bin/bash

# usage:
# . /bin/assumerole.sh arn:aws:iam::AWS_ACCOUNT_ID:role/iam_role external_id

unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN AWS_SECURITY_TOKEN AWS_ACCESS_KEY AWS_SECRET_KEY AWS_DELEGATION_TOKEN

ROLE="${1:-Admin}"
EXTERNAL_ID="${2:-123456789}"
DURATION="${3:-3600}"
NAME="${4:-`hostname -s`}"

KST=(`aws sts assume-role 
      --role-arn "$ROLE" \
      --external-id "$EXTERNAL_ID" \
      --role-session-name "$NAME" \
      --duration-seconds $DURATION \
      --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' \
      --output text`)

export AWS_DEFAULT_REGION="${AWS_DEFAULT_REGION:-us-east-1}"
export AWS_ACCESS_KEY_ID="${KST[0]}"
export AWS_ACCESS_KEY="${KST[0]}"
export AWS_SECRET_ACCESS_KEY="${KST[1]}"
export AWS_SECRET_KEY="${KST[1]}"
export AWS_SESSION_TOKEN="${KST[2]}"
export AWS_SECURITY_TOKEN="${KST[2]}"
export AWS_DELEGATION_TOKEN="${KST[2]}"
