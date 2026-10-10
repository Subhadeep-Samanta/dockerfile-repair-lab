# Dockerfile Repair Lab — Debugging Notes

## 1. Invalid Base Image
**Problem:** `FROM node:notfound` failed because the image tag was invalid.

**Fix:** Replaced it with `FROM node:22-alpine`.

## 2. Incorrect Working Directory
**Problem:** Files were copied before setting the working directory.

**Fix:** Set `WORKDIR /app` before copying application files.

## 3. Incorrect Dependency Installation
**Problem:** `npm install package-lock.json` was not the intended dependency installation command.

**Fix:** Copied `package.json` and `package-lock.json` first and used `npm ci --omit=dev`.

## 4. Missing Source Directory
**Problem:** The Dockerfile attempted to copy a nonexistent `missing-folder`.

**Fix:** Removed that instruction and copied the required `src/` directory instead.

## 5. Incorrect Startup Command
**Problem:** The Dockerfile used `npm run production`, but no production script existed.

**Fix:** Used `CMD ["npm", "start"]`, matching the script in package.json.

## 6. Incorrect Docker Build Context
**Problem:** `.dockerignore` excluded `src`, although app.js imports routes from that directory.

**Fix:** Removed `src` from `.dockerignore` and retained exclusions for node_modules, .env, and .git.

## 7. Build Cache Improvement
Dependency manifests are copied before application code so Docker can reuse the dependency installation layer when only application files change.

## 8. Verification
The API endpoint `/api/status` returned a successful response with status `ok`.

Example response:
`{"status":"ok","timestamp":"2026-10-10T04:10:33.682Z","environment":"development"}`

The timestamp will differ between requests.
