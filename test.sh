set -e

# How they build it upstream
docker build --no-cache -qt upstream/prometheus ./upstream
echo ""
echo "  EXPECT: uid=65534(nobody) gid=65534(nobody)"
echo ""
set -x
docker run -it upstream/prometheus sh -c 'id'
docker run -it upstream/prometheus sh -c 'ls -lah /prometheus'
set +x


# We clone their `master` branch, and build our base:
docker build \
    --build-arg user=sourcegraph \
    --build-arg userid=100 \
    --build-arg group=sourcegraph \
    --build-arg groupid=101 \
    --no-cache -qt downstream/prometheus-base ./upstream

# How we build our Prometheus image
docker build --no-cache -qt downstream/prometheus ./downstream
echo ""
echo "  EXPECT: uid=100(sourcegraph) gid=101(sourcegraph)"
echo ""
set -x
docker run -it downstream/prometheus sh -c 'id'
docker run -it downstream/prometheus sh -c 'ls -lah /prometheus'
set +x