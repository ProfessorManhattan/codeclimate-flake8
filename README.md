# Code Climate Flake8 Engine

`codeclimate-flake8` is a Code Climate engine that wraps the [Flake8](https://github.com/PyCQA/flake8) source code analyzer. You can run it on your command line using the Code Climate CLI, or on our hosted analysis platform.

### Installation

1. If you haven't already, [install the Code Climate CLI](https://github.com/codeclimate/codeclimate).
2. Enable the engine through the beta channel in your .codeclimate.yml file:
```
engines:
  flake8:
    enabled: true
    channel: "beta"
```
3. You're ready to analyze! Browse into your project's folder and run `codeclimate analyze`.

### Configuration

You can configure which files to be analyzed in your `.codeclimate.yml` file.

Other configurations can be made through a `.flake8` file. More information can be found on [Flake8's documentation](http://flake8.pycqa.org/en/latest/)

Plugin activation can also be made in `.codeclimate.yml`:

```
engines:
  flake8:
    enabled: true
    channel: "beta"
```

## ➤ Requirements

- **[Docker](https://gitlab.com/megabyte-labs/ansible-roles/docker)**
- [CodeClimate CLI](https://github.com/codeclimate/codeclimate)

### Optional Requirements

- [DockerSlim](https://gitlab.com/megabyte-labs/ansible-roles/dockerslim) - Used for generating compact, secure images
- [Google's Container structure test](https://github.com/GoogleContainerTools/container-structure-test) - For testing the Docker images


### Building the Docker Container

Run the below make command from the root of this repository to create a local fat docker image
```shell
make image
```

### Building a Slim Container

Run the below make command from the root of this repository to create a local slim docker image
```shell
make slim
```


### Test

Run the below command from the root of this repository to test the images created by this repository.
```shell
make test
```


### Need help?

For help with Flake8, [check out their documentation](http://flake8.pycqa.org/en/latest/).

If you're running into a Code Climate issue, first check out this project's GitHub Issues, as your question may have already been covered. If not, [go ahead and open a support ticket with us](https://codeclimate.com/help).
