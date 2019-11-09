FROM python:3.8.0-buster

## Step 1:
# Create a working directory
WORKDIR /app

## Step 2:
# Copy source code to working directory
COPY . /app/

## Step 3:
# Install packages from requirements.txt
# hadolint ignore=DL3013
RUN python entertainment_center.py &&\
    pip install --upgrade pip &&\
    pip install --trusted-host pypi.python.org -r requirements.txt

## Step 4:
# Expose port 80
EXPOSE 80

## Step 5:
# Deploy static website index.html at container launch
CMD ["python3", "-m", "http.server", "80"]
