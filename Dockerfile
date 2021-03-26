FROM nginx:1.19.3

COPY output /usr/share/nginx/html

RUN for AWS_ACCOUNT_ID in aws_account_id_1 aws_account_id_2 aws_account_id_3; do \
    set -ex && \
    ls -larth /usr/share/nginx/html/${AWS_ACCOUNT_ID}/ && \
    mv /usr/share/nginx/html/${AWS_ACCOUNT_ID}/iam-report-default.html /usr/share/nginx/html/${AWS_ACCOUNT_ID}/index.html \
    ; done

COPY index.html /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
