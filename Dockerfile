FROM public.ecr.aws/awsguru/aws-lambda-adapter:0.7.2 AS lwa
FROM darthsim/imgproxy:v3.21.0-arm64

COPY --from=lwa /lambda-adapter /opt/extensions/lambda-adapter
ENV PORT=8080
ENV AWS_LWA_READINESS_CHECK_PATH=/health

LABEL org.opencontainers.image.source="https://github.com/imgproxy/imgproxy"
