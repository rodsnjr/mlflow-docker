FROM python:3.7.0

RUN pip install mlflow==1.8.0
RUN pip install psycopg2
RUN pip install boto3

EXPOSE 5000

ENV MLFLOW_BACKEND_STORE=sqlite://experiments
ENV S3_ENDPOINT=http://0.0.0.0:4569
ENV BUCKET=mlflow-models
ENV ARTIFACT_ROOT=s3://${BUCKET}/
RUN MLFLOW_S3_ENDPOINT_URL=$S3_ENDPOINT

CMD mlflow server \
    --backend-store-uri ${MLFLOW_BACKEND_STORE} \
    --default-artifact-root ${ARTIFACT_ROOT} \
    --host 0.0.0.0