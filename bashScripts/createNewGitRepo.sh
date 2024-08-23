#Because I always forget:

# Authenticate with GitHub CLI
# gh auth login

# Initialize the Git repository (if not already initialized)
# git init

# Add all files to the repository
git add .

# Commit the files
git commit -m "Initial commit"

# Create a new GitHub repository
gh repo create REPO_NAME --private

# Add the remote repository
git remote add origin https://github.com/YOUR_USERNAME/REPO_NAME.git

# Push the files to the new repository
git push -u origin master
