# The challenge
- a document has a `kind`
- name and organize this `kind` (the hierarchy) will determine how easy it is to search, filter, and maintain the documentation.

From the **strategic (naming)** to the **tactical (implementation)**.

### 1. What to name the "Kind" (Terminology)

In information science, this is called a **Taxonomy**. However, since you are building a hierarchical path (like a file system), here are the best terms to use in your UI and code:

- **`Path`** (Best for Devs): `IT/Projects/Kubernetes/Networking`. This implies a folder-like structure.
- **`Topic`** (Best for Users): Users "browse by Topic" rather than by a cryptic code.
- **`Classification`** (Best for Librarians): Emphasizes that it's a formal system.
- **`Tag`** (If you use flat labels, but you are using a hierarchy, so avoid this).
- **`Domain Path`** (If you want to be explicit).

**My Recommendation:** Name the field **`Topic Path`** in the UI and **`classification_path`** in your database. This tells the user they are navigating a tree, but doesn't force them to understand complex library science jargon.

---

### 2. How to organize the Hierarchy (The "Faceted" Approach)

Your current structure (`IT/prj/kubernetes/...`) is a **single hierarchical tree**. The problem with a single tree is that it forces you to choose one parent. (e.g., Does a "Kubernetes Security" document go under `IT/Security/` or `IT/Projects/Kubernetes/`?)

To solve this, do not use a **Single Tree**. Use a **Faceted Classification** with **Primary/Secondary/Tertiary** levels.

Here is how you organize it:

#### Level 1: The **Macro-Domain** (Who is this for?)
This is the broadest category. Keep this list **small and stable** (max 10).
- `IT`
- `Math`
- `Medicine`
- `Psychology`
- `Business` (Optional)

#### Level 2: The **Archetype** (What is the nature of the document?)
This is the most critical distinction. Instead of mixing "Project" and "Theory" in the same folder, split them here.
- **`Theory`** (Concepts, formulas, fundamentals)
- **`Practice`** (How-to, Tutorials, SOPs)
- **`Project`** (Specific initiatives, deliverables, retrospectives)
- **`Tool`** (Software, equipment, libraries)
- **`Process`** (Workflows, approvals, governance)

#### Level 3: The **Specific Entity** (The actual subject)

Now you combine them.

**Example Structure (The "Path"):**

| Document Title | Topic Path |
| :--- | :--- |
| **Kubernetes Installation Guide** | `IT / Practice / Tool / Kubernetes` |
| **Kubernetes Project Charter** | `IT / Project / Infrastructure / K8s-Migration` |
| **Set Theory Basics** | `Math / Theory / Set / ZFC` |
| **Using Wolfram Alpha** | `Math / Practice / Tool / Wolfram` |
| **Depression CBT Manual** | `Psychology / Practice / Process / CBT` |
| **DSM-5 Criteria** | `Psychology / Theory / Diagnosis / DSM-5` |

---

### 3. The "Tag" Overlay (Crucial for Search)

A strict hierarchy is **brittle**. If a document belongs to two places, don't duplicate it; use **Tags** for the second dimension.

**The Rule:**
- **`Topic Path`** = Where it **lives** (The primary shelf).
- **`Tags`** = What it is **about** (The secondary descriptors).

**Example:**
- **Document:** "Securing Docker Containers"
- **Topic Path:** `IT / Practice / Tool / Docker`
- **Tags:** `Security`, `Networking`, `DevOps`, `Compliance`

Now, if a user clicks "IT" > "Security", they won't find it in the folder, but if they **search** or click the **"Security" tag**, they will find this document immediately.

---

### 4. Database Schema (How to store it)

Do not store the full string `IT/Practice/Tool/Kubernetes` as a single text field. It breaks if you rename "IT" to "Information Technology".

**Store it as an Array or JSON:**

| Document ID | Title | `path` (Array) |
| :--- | :--- | :--- |
| 001 | K8s Guide | `["IT", "Practice", "Tool", "Kubernetes"]` |
| 002 | Set Theory | `["Math", "Theory", "Set", "ZFC"]` |

**Why?** 
- You can query "Give me all documents in the `Tool` sub-domain" instantly.
- You can rename "IT" to "InfoTech" in one query and it updates every document.

---

### 5. UI/UX Naming Convention

When the user creates a new document, do not make them type the path. Use a **Cascading Dropdown**:

1.  **Dropdown 1:** `Domain` (IT, Math, Med)
2.  **Dropdown 2:** `Type` (Theory, Practice, Project, Tool)
3.  **Dropdown 3:** `Subject` (This is a dynamic list that changes based on the first two).

**Label the field in the UI as:**
> **"Document Home"** *or* **"Primary Category"**

**Add a helper text:**
> *"Choose where this document permanently lives. Use Tags below for cross-referencing."*

---

### Summary Checklist for your PTF

1.  **Rename the field** to `Topic Path`.
2.  **Flatten your hierarchy** to exactly 3 levels: `Domain > Archetype > Entity`.
3.  **Separate "Project" and "Tool"** into the Archetype level, not the Entity level.
4.  **Implement Tags** to handle cross-domain topics (e.g., a document about "Statistics" belongs in `Math/Theory/Stats`, but gets a `Psychology` tag).
5.  **Store as an array** in the database, not a string.