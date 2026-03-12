load('./infra/dev/tilt/services.star',
     'go_service',
     'java_service',
     'python_service',
     'rust_service')

go_service('graphql-gateway', 8081)
java_service('items-service', 8082)
python_service('users-service', 8083)
rust_service('mail-service', 8084)
