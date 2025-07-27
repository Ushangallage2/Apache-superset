#!/bin/bash
# gen-secret-key.sh
# Generate a strong, base64-encoded SECRET_KEY for Superset.

# Run:
# ./gen-secret-key.sh

openssl rand -base64 42
