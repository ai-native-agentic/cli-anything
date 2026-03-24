FROM python:3.11-slim

WORKDIR /app

# Install shared dependencies for all CLI harnesses
RUN pip install --no-cache-dir click>=8.0.0 prompt-toolkit>=3.0.0 pytest>=7.0.0

# Copy project source
COPY . .

# Install GIMP harness as example (editable mode)
RUN cd gimp/agent-harness && pip install --no-cache-dir -e .

# Create non-root user
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
RUN chown -R appuser:appgroup /app

USER appuser

# Default: show help
CMD ["cli-anything-gimp", "--help"]
