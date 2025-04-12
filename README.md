
# Setup the development environment

This project uses [devenv](https://devenv.sh/) to declaratively define the development environment.

```shell
# In your host shell: change directory to the location of this project
devenv shell
```

## Additional step (only for NixOS users)

> [!Important]
> When you first start using this project you'll need to create a [Distrobox](https://distrobox.it/)
> container. This is a 1 time event (you don't need to create it every time you enter the project).
>
> ```shell
> ###########################
> # WARNING: only for NixOS
> ###########################
> # In the devenv shell: create a distrobox container to be able to have a
> # Filesystem Hierarchy Standard (FHS) environment, which is assumed by Bazel!
> #
> # Additionally, it was found that the distrobox container was missing the ca-certificates
> # of the host so we mount them with `--volume /etc/ssl/cert:/etc/ssl/certs:ro`
> distrobox --name ubuntubox --volume /etc/ssl/certs:/etc/ssl/certs:ro --image ubuntu:22.04
> ```

Assuming you have already created the distrobox container, you need to enter it as follows:

```shell
# Enter the distrobox container
distrobox enter ubuntubox
```

## Acknowledgments

This is heavily influenced by [ModernCppStarter](https://github.com/TheLartians/ModernCppStarter.git).
