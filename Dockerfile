FROM python:3.7.0

RUN pip install mlflow==1.8.0
RUN pip install psycopg2
RUN pip install boto3

EXPOSE 5000

ENV MLFLOW_BACKEND_STORE=sqlite:///experiments
ENV ARTIFACT_ROOT=/tmp/

CMD mlflow server \
    --backend-store-uri ${MLFLOW_BACKEND_STORE} \
    --default-artifact-root ${ARTIFACT_ROOT} \
    --host 0.0.0.0