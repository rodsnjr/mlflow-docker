FROM python:3.7.0

RUN pip install mlflow==1.8.0
RUN pip install psycopg2
RUN pip install boto3

EXPOSE 5000

ENV MLFLOW_BACKEND_STORE=sqlite://experiments
ENV S3_ENDPOINT=http://0.0.0.0:4569
ENV BUCKET=mlflow-bucket
RUN MLFLOW_S3_ENDPOINT_URL=$S3_ENDPOINT

COPY wait-for-it.sh .
RUN chmod +x wait-for-it.sh

CMD ./wait-for-it.sh postgres:5432 -- mlflow server \
    --backend-store-uri MLFLOW_BACKEND_STORE \
    --default-artifact-root s3://${BUCKET}/ \
    --host 0.0.0.0