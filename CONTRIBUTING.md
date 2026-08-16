# Contributing to ImCurvin

Thank you for taking the time to contribute to ImCurvin. Community contributions are essential for transforming this framework into a highly resilient global asset for security professionals.

Bug reports, vulnerability disclosures, and feature requests are welcome. Please submit them formally through the Issues section.

---

# Submitting Code Changes

Code modifications and enhancement suggestions are welcome via Pull Requests. However, to maintain the structural integrity and performance baseline of the framework, all submittals must strictly adhere to the guidelines outlined below.

## Core Architectural Guidelines

To secure project acceptance and prevent merge conflicts, all code pull requests must comply with these architectural constraints:

1. **Minimalist Execution:** Strictly enforce minimalist scripting patterns. Do not introduce heavy third-party libraries, complex software dependencies, or unnecessary text bloating. Built-in native Linux utilities and zero-forking internal shell primitives are the absolute standard.
2. **Strict Data Decoupling:** Do not hardcode new target sequences, parameter vectors, or payloads directly into the core engine shell scripts. All fuzzing strings, alternative routes, and timing vectors must be modularly appended to their respective dictionary files inside the `data/` directory.

---

## Contribution Workflow

### 1. Payload & Dictionary Submissions
To suggest or inject new operational payloads into the framework:
- Navigate to the designated data/ directory.
- Append your target strings cleanly to the appropriate database tracking file (one entry per line, with all loose whitespaces and trailing carriage returns removed).
- Open a minimal Pull Request or Issue providing the technical justification for why these specific vectors are critical for modern WAF bypass or database timing audits.

### 2. Codebase Maintenance & Bug Fixes
- If you isolate a syntax flaw, regression, or logic error within the core engine scripts or the Python validation modules, please open a detailed issue outlining the steps to reproduce the anomaly before submitting a patch.

---
*By contributing to ImCurvin, you agree that your code will be licensed under the project's original Apache License 2.0.*