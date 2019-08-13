
. "$(dirname "$0")/includes/helpers.sh"

ROOT=$(parent_of_script)
BUILD=$ROOT/build

cd $ROOT;

PACKAGE_JSON=$SRC/package.json
PACKAGE=$(json_get $PACKAGE_JSON name)
echo
heading "Bulding package $PACKAGE"

announce "Is the working directory clean?"
is_git_clean && ok || abort "Working directory must be clean.";

announce "Preparing the build directory in $BUILD"
{
  rm -rf $BUILD;
  mkdir $BUILD;
} && ok || abort;

announce "Copy build.package.json to build/package.json"
cp $PACKAGE_JSON $BUILD/package.json && ok || abort

announce "Copy README.md"
cp $ROOT/README.md $BUILD && ok || abort

announce "Copy LICENSE.md"
cp $ROOT/LICENSE.md $BUILD && ok || abort

# Build this particular package in the build directory
## Customize as necessary.

build_package;
success "$PACKAGE built in $BUILD"
success "$(tput bold)All done.$(tput sgr0)"
