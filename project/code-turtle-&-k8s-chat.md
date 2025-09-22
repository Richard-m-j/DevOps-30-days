# Project Status Update: Code-Turtle & K8s Query Tool

This update covers two key projects:
1.  **Code-Turtle GitHub Actions**: A pair of AI-powered actions for code indexing and automated PR reviews.
2.  **Natural Language K8s Interface**: A tool for querying Kubernetes clusters using plain English.

---

## 1. `code-turtle-indexer` Action 

This action is responsible for creating and maintaining a vector database of the repository's codebase.

* **Purpose**: To efficiently index code and keep the vector database current.
* **Trigger**: Activates automatically whenever new code is **pushed to the `main` branch**.
* **Mechanism**:
    1.  The action intelligently detects which files have been modified in the latest push.
    2.  It then processes and indexes **only the changed files**, ensuring minimal processing time and cost.
    3.  By default, it uses **Pinecone** as the vector database and mini-LM-v6 as the sentence transformer for indexing.

---

## 2. `code-turtle-reviewer` Action 

This action provides automated, AI-driven code reviews on pull requests.

* **Purpose**: To offer insightful, context-aware code reviews to improve code quality and assist human reviewers.
* **Trigger**: Activates when a **new pull request (PR) is raised** or updated.
* **Workflow**: The action utilizes a multi-agent system to generate a comprehensive review and uses claude-3-haiku from amazon bedrock as ai:
    1.  The action begins by analyzing the `git diff` to identify the specific changes in the PR.
    2.  **Orchestrator Agent**: Manages the entire review process, coordinating the other agents.
    3.  **Retriever Agent**: Queries the Pinecone vector database to fetch relevant code snippets and context from the existing codebase.
    4.  **Web Search Agent**: If needed, this agent uses **SERPAPI** to perform web searches for external context on new libraries or APIs.
    5.  **Synthesizer Agent**: This final agent takes all the gathered information to craft a well-structured and insightful code review comment.
* **Final Output**: The generated review is then automatically **posted as a comment on the PR** using the configured `GITHUB_TOKEN`.

---

## 3. Natural Language Kubernetes (k8s) Interface 🗣️

This project, built using **LangGraph**, allows users to interact with a Kubernetes cluster using natural language queries.

* **Purpose**: To simplify cluster monitoring and management by translating plain English questions into `kubectl` commands and user-friendly results.
* **Core Model**: Powered by the **Claude-3-Haiku** model via **Amazon Bedrock**.
* **Agentic Workflow**:
    1.  **Generator Agent**: A user provides a query (e.g., "Which pods are failing in the production namespace?"). This agent translates the query into the appropriate `kubectl` command.
    2.  **Critique Agent**: Before execution, this agent analyzes the generated command. It checks against a predefined set of rules to prevent destructive or unauthorized actions. If the command passes the check, it is executed on the cluster.
    3.  **Summarizer Agent**: The raw output from the `kubectl` command is passed to this agent, which summarizes the information into a clear, human-readable answer for the user.