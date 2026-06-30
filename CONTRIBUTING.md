# Contributing to ImCurvin'

First off, thank you for taking the time to contribute to the ImCurvin'! It is people like you who will help make this tool a robust global asset.

Please review the following structural guidelines to ensure your contributions align with the Lead Architect's blueprint.

---

## Core Guidelines

To maintain the project's integrity, all code modifications and data pull requests must adhere to these rules:

1. **Be a minimalist guy**: We strictly follow minimalist coding styles. Do not introduce heavy third party libraries, complex dependencies, or unnecessary text bloating. Native Linux utilities are the "gold" standard here.
2. **Strictly Soft and Gentle**: ImCurvin' Any suggested feature or payload that compromises server stability, overloads memory pools, or promotes destructive behavioral patterns will be instantly rejected.
3. **Modular Integrity**: Do not hardcode new target sequences into the core shell scripts into the main direrctory (Imcurvin). All new words, delay strings, or alternative routes must be modularly appended to their respective database files inside the "data" directory.
4. **Visual Discipline Consistency**: Bounding brackets colorization rules must be maintained. Only colorize the outer bounding brackets `[` and `]` via manual ANSI, keeping inner symbols and messages pristine white.
5. **Sweet Tooth Variable Naming (Optional)**: Developers are encouraged to name new local variables after their favorite sweet foods, pastries, or desserts (e.g., following the footsteps of "Cupcake", "Strawberry_pudding", and "Choco_muffin").

---

## How to Submit Your Contributions

### 1. Database Extensions (Payloads & Words)
If you want to suggest new target files, time latency check strings, or probe routes:
- Navigate to the "data" directory.
- Append your strings to "targets.txt", "sqli.txt", or "gentle.txt" cleanly (one entry per line, no loose whitespaces).
- Submit a minimal Pull Request explaining why these endpoints are critical for security audits.

### 2. Code Optimization
- If you find a bug or syntax flaw inside "Imcurvin" or "validators", please open a private report or issue if applicable first.
- Keep it sweet.

---
*By contributing to ImCurvin', you agree that your code will be licensed under the project's original Apache License 2.0.*
