FROM python:3.7-alpine as builder
COPY requirements.txt .
RUN apk update \
  && apk add --virtual build-deps autoconf automake g++ make build-deps gcc python3-dev musl-dev
RUN pip install --upgrade pip
RUN pip install --user -r requirements.txt

FROM python:3.7-alpine
COPY --from=builder /root/.local /root/.local
COPY main.py /app/main.py
VOLUME ["/config"]
WORKDIR /app
EXPOSE 8000
ENTRYPOINT ["python", "main.py", "-c", "/config/otus_docker.yaml"]

