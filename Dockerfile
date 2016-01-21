FROM busybox
COPY opt /opt/pipelineinabox

CMD tail -f /opt/pipelineinabox/scripts/*

VOLUME ["/opt/pipelineinabox"]
