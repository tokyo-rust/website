# Tokyo Rust Website

Source code for the Tokyo Rust community website.

## Goals

* Provide a place to share info about the Tokyo Rust community, such as
    * upcoming events
    * past events
    * how to sponsor
    * sponsors list
    * members list
    * contributors list
    * and more
* Provide an opportunity for Tokyo Rust members to participate in a real Rust project

## Project Constraints

* Favor development in Rust over other languages even if Rust may not be the best choice
    * Reason: giving community members a chance to work with Rust in a real project is a priority
* Favor search engine optimization
    * Reason: main purpose of site is to share information. People need to be able to find that information easily via search engine
    * This means server-side rendering or conventional templating is prioritiezed over client-side rendering

## How To Contribute

* Fork this repo
* Make a feature branch
* Make a PR back to the main repo's main branch

## Deployment

This site is currently deployed using both AWS and Netlify:

### Production (AWS)
- Deployed to S3 + CloudFront
- Triggered on push to `main` branch
- Custom domain: https://www.tokyorust.org

### Netlify Deployment
- Deployed to Netlify (parallel deployment)
- Triggered on push to `main` branch
- PR previews automatically created for all pull requests

#### Setting up Netlify Deployment

**Prerequisites:**
1. Create a free Netlify account at https://netlify.com
2. Get your Netlify Personal Access Token:
   - Go to User Settings → Applications → Personal access tokens
   - Click "New access token"
   - Give it a name (e.g., "GitHub Actions")
   - Save the token securely

**Get your Netlify Site ID:**

Option 1 - Create site via Netlify CLI:
```bash
npm install -g netlify-cli
netlify login
cd /path/to/rusttokyo_website
netlify init
```

Option 2 - Create site in Netlify Dashboard:
1. Go to https://app.netlify.com
2. Click "Add new site" → "Import an existing project"
3. Connect to your GitHub repository
4. After creation, find your Site ID in Site settings → General → Site details

**Configure GitHub Secrets:**

Add the following secrets to your GitHub repository (Settings → Secrets and variables → Actions):
- `NETLIFY_AUTH_TOKEN` - Your Personal Access Token from above
- `NETLIFY_SITE_ID` - Your Site ID from above

**How it works:**
- Every push to `main` deploys to both AWS and Netlify
- Every pull request creates a unique preview deployment on Netlify
- Preview URLs are automatically posted as PR comments
- Preview deployments are deleted when the PR is closed
