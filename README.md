See test.sh for how it works.

- This requires us building Prometheus from source whenever we want to upgrade it, but in practice I don't think that is very bad (it's easy to do).
- We would have `sourcegraph/prometheus-base` published on Docker Hub, so changes to our Prometheus image do not require building Prometheus from source of course.
- All code would live in our main repo, we wouldn't need to maintain a fork of prometheus in the long term at all.

```sh
$ ./test.sh 
sha256:efb15fed116a2a65034676858901aa24f7dd10a7291922289e9d3f6557319a4b

  EXPECT: uid=65534(nobody) gid=65534(nobody)

++ docker run -it upstream/prometheus sh -c id
uid=65534(nobody) gid=65534(nobody)
++ docker run -it upstream/prometheus sh -c 'ls -lah /prometheus'
total 8K     
drwxr-xr-x    2 nobody   nogroup     4.0K Jan 22 02:03 .
drwxr-xr-x    1 root     root        4.0K Jan 22 02:03 ..
++ set +x
sha256:9ed30cba2aa1051414ddffcd23940caeb7311ed3e7eadee59fbef0344cfcd2ce
sha256:9ed30cba2aa1051414ddffcd23940caeb7311ed3e7eadee59fbef0344cfcd2ce

  EXPECT: uid=100(sourcegraph) gid=101(sourcegraph)

++ docker run -it downstream/prometheus sh -c id
uid=100(sourcegraph) gid=101(sourcegraph) groups=101(sourcegraph)
++ docker run -it downstream/prometheus sh -c 'ls -lah /prometheus'
total 8K     
drwxr-xr-x    2 sourcegr sourcegr    4.0K Jan 22 02:03 .
drwxr-xr-x    1 root     root        4.0K Jan 22 02:03 ..
++ set +x
```

