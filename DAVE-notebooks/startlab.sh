set -x
export XDG_RUNTIME_DIR=/tmp/ruben-runtime 
chmod 700 /tmp/ruben-runtime 
export RUNLEVEL=3
export DISPLAY=:99.0
which Xvfb
Xvfb :99 -screen 0 1024x768x24 > /dev/null 2>&1 &
sleep 3
set +x
exec "$@"

jupyter lab

