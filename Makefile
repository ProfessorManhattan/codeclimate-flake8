.PHONY: image test

IMAGE_NAME ?= codeclimate/codeclimate-flake8

SLIM_IMAGE_NAME ?= codeclimate/codeclimate-flake8:slim


image:
	docker build --rm -t $(IMAGE_NAME) .

slim: image
	docker-slim build --tag $(SLIM_IMAGE_NAME) --http-probe=false --exec 'flake8 . || continue' --mount "$$PWD/tests/example:/work" --workdir '/work' --preserve-path '/usr/lib/python3.9/site-packages/flake8' $(IMAGE_NAME) && prettier --write slim.report.json 

test: slim
	container-structure-test test --image $(IMAGE_NAME) --config tests/container-test-config.yaml && container-structure-test test --image $(SLIM_IMAGE_NAME) --config tests/container-test-config.yaml
