FROM python:3.9-slim@sha256:980b778550c0d938574f1b556362b27601ea5c620130a572feb63ac1df03eda5 

ENV PYTHONUNBUFFERED True

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

ENV PORT 1234

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install psycopg2-binary

RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0

# As an example here we're running the web service with one worker on uvicorn.
ENV APP_SOURCE /app/src
WORKDIR $APP_SOURCE
CMD exec uvicorn main:app --host 0.0.0.0 --port ${PORT} --workers 1
