## VSCode Remote Dev Container and Scripts for php/php-src

### Setup

  1. clone repostiory or download and unzip it somewhere
  2. startup VSCode and make sure you have the Remote Development for Containers Extension (Remote - Containers / `ms-vscode-remote.remote-containers`) installed
  3. open the path with VSCode, most of the rest will be guided by VSCode like building the container and entering it
  4. if you want to work with your own fork of php/php-src then create `/workspace/scripts/config-override.sh` and add your fork like:
  ```bash
# set fork
PHP_FORKED_REPOSITORY=https://github.com/makadev/php-src.git
  ```
  5. run `/workspace/scripts/fetch-source.sh` which will fetch php/php-src or your fork (in which case php/php-src will be set as upstream

### Scripts

The following scripts can be used/modified to your liking

Building & Testing
* `scripts/build.sh`: fetch source, run buildconf, configure and make (no specific settings, parallel)
* `scripts/test.sh`: run test (parallel, slow!)
* `scripts/coverage.sh`: build php with `--enable-gcov`, run tests (parallel, very slow) and generate coverage output

Source related
* `scripts/fetch-source.sh`: clone or fetch sources and upstream if possible
* `scripts/clean.sh`: try cleaning the source directory from every modification
* `scripts/rebase-upstream-master.sh`: checkout master, fetch and rebase for upstream master (synchronize with upstream)

