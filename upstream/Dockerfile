FROM alpine

ARG user=nobody
ARG group=nogroup
ARG userid=100
ARG groupid=101

# If a user and group arguments were specified, create them.
RUN [[ "$user" != 'nobody' -a "$group" != 'nogroup' ]] && addgroup -g $groupid -S $group && adduser -u $userid -S -G $group -h /home/$user $user || :

RUN mkdir -p /prometheus && \
    chown -R ${user}:${group} /prometheus

USER       ${user}
VOLUME     [ "/prometheus" ]

RUN echo "built as uid=$userid($user) and gid=$groupid($group)"