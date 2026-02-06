#!/bin/bash

# Test script to verify authentication is required for courses/lessons endpoints
# Usage: ./test-auth.sh <supabase-url>

if [ -z "$1" ]; then
  echo "Usage: $0 <supabase-url>"
  echo "Example: $0 https://your-project.supabase.co"
  exit 1
fi

SUPABASE_URL="$1"

echo "Testing authentication requirements..."
echo "======================================"
echo ""

# Test 1: Courses endpoint without auth
echo "Test 1: GET /functions/v1/courses (no auth)"
echo "Expected: 401 Unauthorized"
curl -s -o /dev/null -w "Status: %{http_code}\n" -X POST "$SUPABASE_URL/functions/v1/courses" \
  -H "Content-Type: application/json"
echo ""

# Test 2: Lessons endpoint without auth
echo "Test 2: POST /functions/v1/lessons (no auth)"
echo "Expected: 401 Unauthorized"
curl -s -o /dev/null -w "Status: %{http_code}\n" -X POST "$SUPABASE_URL/functions/v1/lessons" \
  -H "Content-Type: application/json" \
  -d '{"id": "test-id"}'
echo ""

# Test 3: Courses endpoint with invalid token
echo "Test 3: GET /functions/v1/courses (invalid token)"
echo "Expected: 401 Unauthorized"
curl -s -o /dev/null -w "Status: %{http_code}\n" -X POST "$SUPABASE_URL/functions/v1/courses" \
  -H "Authorization: Bearer invalid-token-12345" \
  -H "Content-Type: application/json"
echo ""

# Test 4: Lessons endpoint with invalid token
echo "Test 4: POST /functions/v1/lessons (invalid token)"
echo "Expected: 401 Unauthorized"
curl -s -o /dev/null -w "Status: %{http_code}\n" -X POST "$SUPABASE_URL/functions/v1/lessons" \
  -H "Authorization: Bearer invalid-token-12345" \
  -H "Content-Type: application/json" \
  -d '{"id": "test-id"}'
echo ""

echo "======================================"
echo "Testing complete!"
echo ""
echo "All tests should return 401 Unauthorized"
