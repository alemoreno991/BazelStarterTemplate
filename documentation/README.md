# Alejandro Title

```shell
bazel build @hedron_compile_commands//:refresh_all \
  --action_env=NIX_LD=$NIX_LD \
  --action_env=NIX_LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH \
  --host_action_env=NIX_LD=$NIX_LD \
  --host_action_env=NIX_LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
```
