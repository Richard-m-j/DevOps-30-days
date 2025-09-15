### Current Stage: GitHub Marketplace Action

A GitHub Action that automatically reviews pull requests.

* **How it Works:** On a PR, the action runs a local LLM which can be user configured. Utilizes a llama cpp image made for this purpose, inside the GitHub runner to analyze the code difference and posts a review. Currently uses only the git diff to give comments.
* **Key Advantages:**
    * **Free to Use:** Runs on free GitHub Actions compute.
    * **Secure:** Code never leaves the GitHub environment.
    * **Customizable:** Supports any GGUF-compatible AI model.

***

### Next Stage: Agentic AI Review Service

An advanced service providing context-aware reviews.

* **How it Works:** A PR triggers a multi-agent system.
    1.  **Code Agent:** Retrieves context by performing a semantic search on the entire codebase (indexed in a Vector DB).
    2.  **Web Agent:** Fetches external information like documentation or best practices.
    3.  **Writing Agent:** Combines all information to generate an in-depth review.
* **Goal:** To deliver reviews that understand the full impact of code changes, not just the isolated diff.