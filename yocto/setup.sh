# assume we're in the same dir as layers
if [ -n "$BASH_SOURCE" ]; then
  SCRIPT=$BASH_SOURCE
else
  SCRIPT=$0
fi
LAYERS_ROOT="$(realpath -e "$(dirname "$SCRIPT")")"

. ${LAYERS_ROOT}/../.config

if [ -z "$MACHINE" ]; then
  echo "MACHINE not set, not doing anything"
  return 1
else
  export MACHINE

  if [ -n "$YOCTO_SOURCE_MIRROR_DIR" ]; then
    export INHERIT="own-mirrors"
    export SOURCE_MIRROR_URL=file://${YOCTO_SOURCE_MIRROR_DIR%/}/
    export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS SOURCE_MIRROR_URL INHERIT"
  fi

  . "${LAYERS_ROOT}/poky/oe-init-build-env" "$@"

  for layer in ${LAYERS}; do
    grep ${layer} conf/bblayers.conf 2>/dev/null 1>&2 || \
      printf 'BBLAYERS += "%s/${layer}"\n' "$LAYERS_ROOT" >> conf/bblayers.conf
  done
fi
