[//]: #(home)
[home]: ../../README.md



[↖][home]

Related topics

| Topic | Location | Kind |
|-|-|-|
|[How-to for project](../../about/howto/ep.md)|internal
|[List of projects](../../README.md)|see


<h1 align="center">KPI</h1>

# Definition

* Stands for **K**ey **P**erformance **I**ndicator.
* Is a **measurable value** used to track **progression**.
* Measures how effectively a **project, product, service, or individual** is **progressing** through its **phases, steps, or milestones**.


> **A KPI is a quantifiable measure that tells you whether you are achieving your desired outcome at each phase of your project, product, or service lifecycle. It helps you make informed decisions, course-correct early, and demonstrate value to stakeholders.**

# Anatomy of a Good KPI

| Element | Description | Example |
|---------|-------------|---------|
| **Metric** | What you measure | "Customer satisfaction" |
| **Target** | The goal or benchmark | "≥ 85%" |
| **Source** | Where the data comes from | "Post-service survey" |
| **Frequency** | How often you measure | "Monthly" |
| **Owner** | Who is responsible | "Head of Customer Success" |


# KPI vs. Metric vs. Measure

| Term | Definition | Example |
|------|------------|---------|
| **Measure** | A raw data point | "342 support tickets today" |
| **Metric** | A calculated value from one or more measures | "Average tickets per day = 342" |
| **KPI** | A metric tied to a strategic objective with a target | "Average tickets per day ≤ 300 (target)" |


# The SMART Criteria for KPIs

| Letter | Meaning | Question to Ask |
|--------|---------|-----------------|
| **S** | **Specific** | Is it clear exactly what we're measuring? |
| **M** | **Measurable** | Can we quantify it with data? |
| **A** | **Achievable** | Is the target realistic? |
| **R** | **Relevant** | Does it matter to our goal? |
| **T** | **Time-bound** | Is there a timeframe? |

**Quick Checklist**: Is This a Good KPI?

- Can I measure it with data I have or can collect?
- Does it have a clear target or benchmark?
- Can I influence it through my actions?
- Is it directly tied to a phase objective?
- Is it simple enough to explain to a stakeholder in one sentence?
- Does it help me decide whether to continue, pivot, or stop?

# Kind

| Type | Purpose | Example |
|------|---------|---------|
| **Lagging KPI** | Measures past performance (outcome) | Revenue, customer churn, defect rate |
| **Leading KPI** | Predicts future performance (driver) | Pipeline velocity, training hours, code commits |
| **Input KPI** | Measures resources invested | Budget spent, hours worked |
| **Output KPI** | Measures what was produced | Units shipped, features released |
| **Process KPI** | Measures efficiency | Cycle time, throughput |
| **Outcome KPI** | Measures impact | Customer satisfaction, ROI |


# KPI Hierarchy

```
┌─────────────────────────────────────────────────────┐
│  STRATEGIC KPIs (Executive Level)                  │
│  "Are we winning?"                                 │
│  Examples: Revenue growth, Market share, ROI      │
└──────────────────────┬──────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────┐
│  TACTICAL KPIs (Management Level)                  │
│  "Are we executing the plan?"                      │
│  Examples: Project completion %, Budget adherence  │
└──────────────────────┬──────────────────────────────┘
                       ↓
┌─────────────────────────────────────────────────────┐
│  OPERATIONAL KPIs (Team/Individual Level)          │
│  "Are we doing things right?"                      │
│  Examples: Tasks completed, Response time          │
└─────────────────────────────────────────────────────┘
```


# Good vs. Bad KPIs

| Good KPI ✅ | Bad KPI ❌ |
|-------------|-----------|
| Measurable with reliable data | Vague or subjective |
| Tied to a clear objective | No connection to strategy |
| Actionable — you can influence it | Out of your control |
| Simple and easy to understand | Complex and confusing |
| Measured consistently over time | Changes arbitrarily |
| Limited in number (≤ 5 per goal) | Too many to focus |


# Example: Single KPI Breakdown

| Element | Example |
|---------|---------|
| **KPI Name** | Customer Satisfaction Score (CSAT) |
| **Definition** | Percentage of customers rating their experience as "Satisfied" or "Very Satisfied" |
| **Formula** | (Satisfied responses / Total responses) × 100 |
| **Target** | ≥ 90% |
| **Data Source** | Post-interaction survey |
| **Frequency** | Monthly |
| **Owner** | Customer Experience Manager |
| **Type** | Outcome / Lagging |
| **Why it matters** | High CSAT = higher retention, referrals, and revenue |


# Quick Checklist: Is This a Good KPI? — Software Development Edition

---

## ✅ Good KPI Checklist (Software Dev)

| # | Check | Why It Matters | Example ✅ | Example ❌ |
|---|-------|----------------|------------|------------|
| 1 | **Can I measure it with data I have or can collect?** | No data = no KPI | Deployment frequency (from CI/CD logs) | "Developer happiness" (no formal measurement) |
| 2 | **Does it have a clear target or benchmark?** | Targets give purpose | "Deploy 5x per day" | "Deploy more often" |
| 3 | **Can I influence it through my actions?** | Useless if uncontrollable | Code review turnaround time | "Company stock price" |
| 4 | **Is it directly tied to a phase objective?** | Must connect to the "Why" | Test coverage % (Phase 5: Verification) | "Lines of code written" (output ≠ value) |
| 5 | **Is it simple enough to explain in one sentence?** | Complex KPIs confuse | "Cycle time = time from commit to deploy" | "Weighted defect density per complexity-adjusted function point" |
| 6 | **Does it help me decide whether to continue, pivot, or stop?** | Must drive action | High bug count → Stop & fix | "Total commits per day" (just vanity) |
| 7 | **Is it resistant to gaming / perverse incentives?** | Don't incentivize bad behavior | DORA metrics (balanced) | "Lines of code" (encourages bloated code) |
| 8 | **Does it focus on outcomes, not just activity?** | Activity ≠ value | Lead time for changes | "Hours coded" |
| 9 | **Is it measured consistently over time?** | Trend tracking matters | Weekly measuring on same day | Measuring randomly |
| 10 | **Is it limited in number (≤ 5 per phase)?** | Focus or fail | 3-5 per phase | 15 KPIs for one phase (paralysis) |

---

## Bad KPI Examples — Software Dev

| Bad KPI | Why It's Bad | What to Use Instead |
|---------|--------------|---------------------|
| **Lines of Code (LOC)** | Rewards verbosity, not value | Code complexity score, feature delivery |
| **Number of Bugs Fixed** | Punishes teams with fewer bugs | Defect detection rate, escaped defects |
| **Developer Hours Worked** | Rewards inefficiency, burnout | Cycle time, throughput |
| **Code Commits Count** | Vanity metric, no quality signal | PR acceptance rate, deployment frequency |
| **Story Points Completed** | Easy to inflate, irrelevant to value | Business value delivered, customer adoption |
| **Test Cases Written** | Quantity ≠ quality | Test coverage %, mutation score |
| **Availability (uptime) 100%** | Unrealistic, measures luck | SLA compliance (e.g., 99.9%) |
| **Velocity** | Over-focus on speed, not quality | DORA metrics (combined view) |

---

## Good KPI Examples — Software Dev (by Phase)

| Phase | Good KPI | Target | Why It's Good |
|-------|----------|--------|---------------|
| **Vision / Goal** | Stakeholder alignment % | ≥ 85% | Measures shared understanding before building |
| **Requirements** | Requirement churn rate | ≤ 10% per sprint | Keeps scope creep under control |
| **Roadmap / Planned Work** | Sprint commitment accuracy | ≤ 20% variance | Plan vs. reality check |
| **Implementation** | Cycle time (commit → deploy) | < 1 hour | Speed of delivery |
| **Verification & Validation** | Defect escape rate | < 5% | Bugs caught before production |
| **Operations** | MTTR (Mean Time to Resolve) | < 60 minutes | How fast you recover |
| **Measurement & Improvement** | Engineering productivity index | > 80% | Balanced efficiency view |
| **Feedback Loop** | Feedback implementation time | < 2 weeks | Speed of learning |

---

## Top 5 Most Powerful KPIs in Software Development

*(DORA Metrics — Industry Standard)*

| KPI | Definition | Good Target |
|-----|------------|-------------|
| **Deployment Frequency** | How often you deploy to production | On-demand / multiple times per day |
| **Lead Time for Changes** | Time from code commit to deployment in production | < 1 hour |
| **Mean Time to Recover (MTTR)** | Time from incident to resolution | < 1 hour |
| **Change Failure Rate** | % of deployments causing incidents | ≤ 15% |
| **Defect Escape Rate** | % of defects found in production vs. testing | < 5% |

---

## One-Sentence KPI Test

> **"If I improve this KPI, will I actually deliver more value to my users, or am I just making a number look better?"**

---

## KPI Selection Worksheet (Software Dev)

For each potential KPI, answer:

| Question | Score (1-10) |
|----------|--------------|
| Can I measure it with existing tools? | |
| Will it drive the right behavior? | |
| Is the target clear and realistic? | |
| Does it connect to user/business value? | |
| Is it resistant to gaming? | |

**Rule:** Only keep KPIs with average score ≥ 8.

---

Would you like me to:
- Provide **DORA metrics in depth** with how to measure them?
- Map KPIs to specific **tools** (Jira, GitHub, GitLab, etc.)?
- Create a **KPI dashboard template** for your team?


---

Would you like me to:
- Add **KPI formulas** for each of the 8 phases?
- Create a **KPI selection worksheet** to pick the right KPIs for any project?
- Provide **industry benchmarks** for common KPIs?


