# vim:set sw=8 ts=8 noet:
#
# Copyright 2016 The Kubernetes Authors.
# Copyright 2017 Torchbox Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

REPOSITORY	?= foundery.azurecr.io/k8s-hostpath-provisioner
TAG		?= $(shell git describe --tags --abbrev=0)
IMAGE		= ${REPOSITORY}:${TAG}

image: hostpath-provisioner
	docker build -t $(IMAGE) -f Dockerfile .

vendor:
	glide install -v

hostpath-provisioner: hostpath-provisioner.go
	CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o hostpath-provisioner .

clean:
	rm hostpath-provisioner

.PHONY: clean vendor image
