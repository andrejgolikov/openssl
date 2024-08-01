@ECHO off

docker run ^
    --name ga_localhost_tools_openssl ^
    --rm ^
    -it ^
    -v %~dp0\..\docker\ssl\openssl.cnf:/etc/ssl/openssl.cnf:ro ^
    -v %~dp0\..\docker\entrypoint.sh:/root/bin/entrypoint.sh:ro ^
    -v %~dp0\..\keys:/root/bin/keys ^
    -w /root/bin/keys ^
    --entrypoint ./../entrypoint.sh ^
    alpine/openssl
