GBE — Gstack BOSH Environment
=============================

This project proposes conventions and an opinionated workflow in order to
create BOSH 2 environments. Configuration is located in the `conf/` directory,
and infrastructure and deployment state are in the `state/` directory.


Prerequisites
-------------

- Install [Virtualbox](https://www.virtualbox.org/wiki/Downloads)
  version `5.1+`, as advised in the
  [BOSH Lite on VirtualBox](https://github.com/cloudfoundry/bosh-deployment/blob/bedbfc9bbf15df64fb9e34343b3a18995d4ca709/docs/bosh-lite-on-vbox.md#bosh-lite-on-virtualbox)
  guide.

- Install `direnv`. Like `brew install direnv` or anything similar.

- Have a [bosh-deployment](https://github.com/cloudfoundry/bosh-deployment)
  clone, next to this repo. Its path will be configured in
  `UPSTREAM_DEPLOYMENT_DIR`.


How to configure
----------------

Configuration files are located in the `conf/` directory.

- In `env-config.inc.bash`, set a few variables and don't forget to re-run
  `direnv allow` after that.

  - Set `UPSTREAM_DEPLOYMENT_DIR` to be the path to the deployment repo clone,
    as mentioned above.

  - Set `MAIN_DEPLOYMENT_FILE` to point to the main deployment file, usually
    in the upstream deployment directory.

  - Set `BOSH_ENVIRONMENT_ALIAS` to be the name of your BOSH environement, as
    you'll see it in `bosh environments` and in `-e` arguments to the BOSH CLI
    v2.

- In `env-operations-layout.inc.bash` you can configure the set of operation files
  that will patch (using
  [go-patch](https://github.com/cppforlife/go-patch/blob/master/docs/examples.md))
  the main deployment file.

- In `env-depl-vars.yml` you set the configuration variables that will be injected into
  the patched deployment manifest for your BOSH environement.


Usage workflow
--------------

### Basic usage

1. Create your environment with the `create-env` command.

2. Setup your shell with `source bin/shell-setup.inc.bash`.

3. Play with your BOSH 2

4. Destroy your environment with the `delete-env` command.


### Advanced usage

1. Tweak your BOSH deployment, adding custom variables in `env-depl-vars.yml`,
   custom layout of operation files in `env-operations-layout.inc.bash`,
   possibly refering custom operation files in the `operation/` subdirectory.

2. Check the new setup interpolates nicely, running `verify-env`.

3. Go to [basic usage](#basic-usage) and have fun with your customized BOSH
   environment.


A note on state and credential files
------------------------------------

State files are located in the `state/` directory. These are generated runtime
files. Some need to be tracked in version control, some not, and for some it
depends on the context.

As `env-creds.yml` contain credentials, it is excluded from version control,
as you'll see in `.gitignore`.

On the opposite, `env-infra-state.json` doesn't contain credentials, but
identification data useful to manage the infrastructure of your BOSH
environment.

Generally, infrastructure state files are advised to be tracked by version
control when they refers to a perpetual environements, or environments that
don't change often. When they refer to ephemeral environements, then you can
exclude them from version control.
 
The `env-depl-manifest.yml` doesn't contain any credentials either. It
reflects the current state the superstructure of your BOSH environment. It is
to be tracked by version control.
