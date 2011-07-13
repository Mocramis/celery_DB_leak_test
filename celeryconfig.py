##Broker settings
BROKER_HOST = "localhost"
BROKER_PORT = 5672
BROKER_USER = "ltu"
BROKER_PASSWORD = "ltu"
BROKER_VHOST = "/"
#CELERY_RESULT_BACKEND = "amqp"
CELERY_IMPORTS = ('celery_memory_leak',)

# configure backend to postgresql
CELERY_RESULT_BACKEND = "database"
CELERY_RESULT_DBURI = "postgresql://postgres:postgres@localhost/mycelery"


