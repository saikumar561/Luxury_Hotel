from os import environ as env
import os
#import multiprocessing

PORT = int(env.get("PORT", 8000))
DEBUG_MODE = int(env.get("DEBUG_MODE", 1))

# AWS Info
AWS_BUCKET = os.environ.get('aws_bucket_name')
AWS_S3_KEY = os.environ.get('aws_access')
AWS_S3_SECRET = os.environ.get('aws_secret')

# Database Info
DB_HOST_NAME = os.environ.get('db_host_name')
DB_USER = os.environ.get('db_username')
DB_PASSWORD = os.environ.get('db_password')
DB_NAME = os.environ.get('db_name')
DB_PORT = os.environ.get('db_port')

# Gunicorn config
bind = ":" + str(PORT)
#workers = multiprocessing.cpu_count() * 2 + 1
#threads = 2 * multiprocessing.cpu_count()