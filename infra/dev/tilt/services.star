# =====================================================
# GO SERVICE
# =====================================================

def go_service(name, port):

    local_resource(
        name + "-build",
        '''
        mkdir -p build && \
        cd services/''' + name + ''' && \
        CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ../../build/''' + name + ''' .
        ''',
        deps=['services/' + name],
    )

    docker_build(
        name + "-image",
        ".",
        dockerfile="./infra/dev/docker/" + name + ".Dockerfile",
        only=["build/" + name],
        live_update=[
            sync("build/" + name, "/app/" + name)
        ],
    )

    k8s_yaml("./infra/dev/k8s/" + name + "-deployment.yaml")

    k8s_resource(
        name,
        port_forwards=port,
        resource_deps=[name + "-build"],
    )


# =====================================================
# JAVA SERVICE
# =====================================================

def java_service(name, port):

    local_resource(
        name + "-build",
        '''
        cd services/''' + name + ''' && \
        ./mvnw package -Dmaven.test.skip=true && \
        mkdir -p ../../build && \
        cp target/''' + name + '''.jar ../../build/''' + name + '''.jar
        ''',
        deps=[
            "services/" + name + "/src",
            "services/" + name + "/pom.xml",
        ],
        ignore=["services/" + name + "/target"],
    )

    docker_build(
        name + "-image",
        ".",
        dockerfile="./infra/dev/docker/" + name + ".Dockerfile",
        only=["build/" + name + ".jar"],
        live_update=[
            sync("build/" + name + ".jar", "/app/" + name + ".jar")
        ],
    )

    k8s_yaml("./infra/dev/k8s/" + name + "-deployment.yaml")

    k8s_resource(
        name,
        port_forwards=port,
        resource_deps=[name + "-build"],
    )


# =====================================================
# PYTHON SERVICE
# =====================================================

def python_service(name, port):

    docker_build(
        name + "-image",
        ".",
        dockerfile="./infra/dev/docker/" + name + ".Dockerfile",
        live_update=[
            sync("services/" + name, "/app")
        ],
    )

    k8s_yaml("./infra/dev/k8s/" + name + "-deployment.yaml")

    k8s_resource(
        name,
        port_forwards=port,
    )


# =====================================================
# RUST SERVICE
# =====================================================

def rust_service(name, port):

    local_resource(
        name + "-build",
        '''
        mkdir -p build && \
        docker run --rm \
            -v $(pwd)/services/''' + name + ''':/app \
            -v $(pwd)/build:/build \
            -w /app \
            rust:1.82 \
            bash -c "cargo build --release && cp target/release/''' + name + ''' /build/''' + name + '''"
        ''',
        deps=[
            "services/" + name + "/src",
            "services/" + name + "/Cargo.toml",
        ],
    )

    docker_build(
        name + "-image",
        ".",
        dockerfile="./infra/dev/docker/" + name + ".Dockerfile",
        only=["build/" + name],
        live_update=[
            sync("build/" + name, "/app/" + name)
        ],
    )

    k8s_yaml("./infra/dev/k8s/" + name + "-deployment.yaml")

    k8s_resource(
        name,
        port_forwards=port,
        resource_deps=[name + "-build"],
    )