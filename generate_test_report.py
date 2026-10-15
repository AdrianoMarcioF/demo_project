
import json
from pathlib import Path
from datetime import datetime, timezone

# Project paths
project_dir = Path(__file__).resolve().parent
results_file = project_dir / "target" / "run_results.json"
report_file = project_dir / "testrun_summary_report.txt"

# Read dbt results
with results_file.open("r", encoding="utf-8") as file:
    data = json.load(file)

results = data.get("results", [])

# Count test statuses
total = len(results)
passed = sum(r.get("status") == "pass" for r in results)
failed = sum(r.get("status") == "fail" for r in results)
errors = sum(r.get("status") == "error" for r in results)
skipped = sum(r.get("status") == "skipped" for r in results)
warnings = sum(r.get("status") == "warn" for r in results)

metadata = data.get("metadata", {})
generated_at = metadata.get("generated_at", "Unknown")
dbt_version = metadata.get("dbt_version", "Unknown")

lines = [
    "DBT TEST RUN SUMMARY REPORT",
    "=" * 35,
    "",
    f"Project: dbt_course",
    f"dbt version: {dbt_version}",
    f"Generated at (UTC): {generated_at}",
    "",
    "OVERALL SUMMARY",
    "-" * 35,
    f"Total tests run: {total}",
    f"Passed: {passed}",
    f"Failed: {failed}",
    f"Errors: {errors}",
    f"Warnings: {warnings}",
    f"Skipped: {skipped}",
    "",
    "TEST DETAILS",
    "-" * 35,
]

for result in results:
    test_name = result.get("unique_id", "Unknown test")
    status = result.get("status", "unknown").upper()
    duration = result.get("execution_time", 0)
    failures = result.get("failures", 0)

    lines.append(
        f"{status:7} | {test_name} | "
        f"Duration: {duration:.3f}s | Failures: {failures}"
    )

elapsed = data.get("elapsed_time", 0)
lines.extend([
    "",
    f"Total execution time: {elapsed:.2f} seconds",
])

report_file.write_text("\n".join(lines), encoding="utf-8")

print(f"Report generated: {report_file}")
