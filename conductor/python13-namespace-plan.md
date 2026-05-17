# Python 3.13 Upgrade & Docker Namespace Plan

## Objective
Upgrade all Python environments to Python 3.13 and provide a mechanism/documentation for customizing the Docker Hub push destination (namespace).

## 1. Python 3.13 Upgrade Strategy
Currently, the `base` sandbox uses `debian:stable-slim` and installs `python3` (which resolves to 3.11 on Debian Bookworm). 
To elegantly upgrade to Python 3.13 without compiling from source, we will change the base image from `debian:stable-slim` to the official `python:3.13-slim` image. 
- `python:3.13-slim` is built on top of Debian Bookworm, meaning it is 100% compatible with our existing `apt` setups, but it comes with Python 3.13 officially pre-installed and optimized.

**Steps:**
1. Update `sandboxes/base/Dockerfile`: Change `FROM debian:stable-slim` to `FROM python:3.13-slim`.
2. Remove `python3` and `python3-pip` from the `apt-get install` list, as they are now natively provided by the base image.
3. Batch update all `README.md` and `templates/GEMINI.md` files to replace references to "Python 3.11" with "Python 3.13".

## 2. Docker Namespace Parameterization
The user noted: `"docker push dariosena/gemini-sandbox-cpp:tagname" is there a way to remove my username dariosena and use something else?`

Currently, the GitHub Actions workflow uses `${{ secrets.DOCKER_USERNAME }}` for both logging into Docker Hub and tagging the images.

**Steps to Parameterize:**
1. In `.github/workflows/docker-build-push.yml`, introduce an `env` variable at the workflow level: `DOCKER_NAMESPACE: ${{ vars.DOCKER_NAMESPACE || secrets.DOCKER_USERNAME }}`.
2. Update the workflow to use `${{ env.DOCKER_NAMESPACE }}` when tagging images and updating descriptions, while keeping `${{ secrets.DOCKER_USERNAME }}` *only* for the login step.
3. Add a section to the root `README.md` explaining that users can define a `DOCKER_NAMESPACE` repository variable in GitHub to push images to an Organization or a different namespace than their login username.

## Verification
- Review changes to GHA workflow to ensure `docker/metadata-action` and `docker/build-push-action` use the new namespace.
- Ensure all Python 3.11 strings are updated across the 22 documentation files.