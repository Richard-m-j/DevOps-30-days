# Essential Git Commands

A summary of basic Git commands for version control.

---

## First-Time Setup

After installing Git, you need to configure your user name and email address.

* **`git config --global user.name "Your Name"`**: Sets the name that will be attached to your commits.
* **`git config --global user.email "your.email@example.com"`**: Sets the email that will be attached to your commits.
* **`git config --list`**: Lets you check your current settings.

---

## Basic Local Workflow

This is the standard process for tracking changes on your local machine. It involves three main areas: the **Working Directory** (your actual files), the **Staging Area** (where you prepare changes), and the **Repository** (where Git saves the project history).

* **`git init`**: Creates a new Git repository in your current folder.
* **`git status`**: Shows the current state of your project, including changed or untracked files.
* **`git add <file>`**: Adds files from your working directory to the staging area, preparing them to be saved. Use `git add .` to add all files.
* **`git commit -m "Your message"`**: Saves the staged changes to your local repository with a short, descriptive message.
* **`git log`**: Shows the history of all the commits you have made.

---

## Working with Branches

Branches are parallel versions of your project that let you work on new features without affecting the main codebase.

* **`git branch`**: Lists all of the branches in your repository.
* **`git branch <branch-name>`**: Creates a new branch.
* **`git checkout <branch-name>`**: Switches your current working directory to the specified branch. The `git switch <branch-name>` command does the same thing.
* **`git merge <branch-name>`**: Combines the changes from another branch into your current branch.

---

## Working with Remote Repositories

Remote repositories are versions of your project stored on the internet, like on GitHub.

* **`git clone <url>`**: Downloads a project and its entire version history from a remote location.
* **`git remote -v`**: Shows the remote repositories your local project is connected to.
* **`git pull origin main`**: Fetches changes from a remote repository and merges them into your current branch.
* **`git push origin <branch-name>`**: Uploads your committed changes from a local branch to a remote repository.

---

## Other Useful Commands

* **`.gitignore`**: This is a special file where you can list files or directories that you want Git to ignore and not track.
* **`git diff`**: Shows the changes between your working directory and the staging area.
* **`git stash`**: Temporarily saves changes that you have not committed, so you can switch branches and work on something else.

