# imgproxy-aws-lambda
ARM64 `imgproxy` container image mirrored to AWS ECR with GitHub Actions.

## Repository contents

The image is defined in `Dockerfile` and currently just pins the upstream
`darthsim/imgproxy` image tag and adds an OCI source label.

## Release flow

Dependabot checks this repository daily for updates to:

- the `darthsim/imgproxy` base image tag in `Dockerfile`
- GitHub Actions used by the workflows

When an imgproxy version bump in `Dockerfile` is merged into `main`,
`.github/workflows/auto-tag.yml` compares the previous and current `Dockerfile`
contents. If the imgproxy base image tag changed, it creates the matching Git tag,
for example `v3.31.1-arm64`.

Pushing that Git tag triggers `.github/workflows/ecr.yml`, which builds and publishes
the ARM64 image to AWS ECR.

## Required GitHub secrets

The ECR publish workflow runs in the `ecr-publish` environment, which only
deploys from `main` and `v*` tags. It expects these environment secrets:

- `AWS_IAM_ROLE`: the push role from `terraform output image_push_role_arns` in
  terraform-devops
- `AWS_ACCOUNT_ID`: the devops account, `960471713478`

The registry and the push role live in terraform-devops. Organization accounts
and their Lambda functions may pull the image; nobody else can.
