# Armakub

Armakub is an ARM64-first fork of Omakub. Turn a fresh Ubuntu installation into a fully-configured, beautiful, and modern web development system by running a single command. No need to write bespoke configs for every essential tool just to get started or to be up on all the latest command-line tools. Armakub keeps Omakub's opinions while ensuring modern ARM laptops and desktops feel first-class.

Watch the introduction video and read more about the original project at [omakub.org](https://omakub.org).

## Contributing to the documentation

Please help us improve Omakub's documentation on the [basecamp/omakub-site repository](https://github.com/basecamp/omakub-site).

## License

Omakub is released under the [MIT License](https://opensource.org/licenses/MIT).

## Extras

While omakub is purposed to be an opinionated take, the open source community offers alternative customization, add-ons, extras, that you can use to adjust, replace or enrich your experience.

[⇒ Browse the omakub extensions.](EXTENSIONS.md)

## Install

Run the bootstrap script on a fresh Ubuntu Desktop 24.04+ machine:

```
wget -qO- https://raw.githubusercontent.com/jwerby/armakub/main/boot.sh | bash
```

You can override the source repository or branch/tag with the `OMAKUB_REMOTE` and `OMAKUB_REF` environment variables when invoking the script.

Once installed, both `armakub` (new) and `omakub` (legacy) commands are available in your shell so existing muscle-memory still works.

## Supported platforms

Omakub targets Ubuntu Desktop 24.04 or newer on 64-bit systems. The installer now runs on both traditional x86_64/amd64 machines and ARM64/aarch64 hardware. A handful of optional third-party applications only publish x86_64 builds; during installation those entries are skipped automatically on ARM with a short notice so the rest of the setup can complete successfully.
