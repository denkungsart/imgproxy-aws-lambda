# imgproxy-aws-lambda
Imgproxy Docker image with AWS Lambda Web Adapter

## Release flow

Dependabot updates the `darthsim/imgproxy` tag in `Dockerfile`.

When that change is merged into `main`, `.github/workflows/auto-tag.yml` compares the
previous and current `Dockerfile` contents. If the imgproxy base image tag changed, it
creates the matching Git tag, for example `v3.31.1-arm64`.

Pushing that Git tag triggers `.github/workflows/ecr.yml`, which builds and publishes the
ARM64 image to AWS ECR.
