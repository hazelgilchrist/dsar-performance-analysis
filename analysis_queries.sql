-- DSAR Performance Analysis
-- Author: Hazel Gilchrist
-- Data source: synthetic_dsar_cases.csv
-- Note: This project uses entirely synthetic data and contains no customer,
-- colleague or company information.

-- 1. Overall SLA performance
-- Calculates total cases, breached cases and the overall breach rate.
SELECT
  COUNT(*) AS total_cases,
  COUNTIF(sla_status = 'Breached') AS breached_cases,
  ROUND(100 * COUNTIF(sla_status = 'Breached') / COUNT(*), 1) AS breach_rate_pct
FROM
  `dsar-performance-analysis.dsar_analysis.dsar_cases`;


-- 2. Performance by case complexity
-- Compares workload, completion time and breach rate across complexity levels.
SELECT
  complexity,
  COUNT(*) AS total_cases,
  ROUND(AVG(completion_days), 1) AS avg_completion_days,
  COUNTIF(sla_status = 'Breached') AS breached_cases,
  ROUND(100 * COUNTIF(sla_status = 'Breached') / COUNT(*), 1) AS breach_rate_pct
FROM
  `dsar-performance-analysis.dsar_analysis.dsar_cases`
GROUP BY
  complexity
ORDER BY
  avg_completion_days;


-- 3. Monthly performance trend
-- Tracks completion time and breach rate from January to June 2026.
SELECT
  month_received,
  COUNT(*) AS total_cases,
  ROUND(AVG(completion_days), 1) AS avg_completion_days,
  COUNTIF(sla_status = 'Breached') AS breached_cases,
  ROUND(100 * COUNTIF(sla_status = 'Breached') / COUNT(*), 1) AS breach_rate_pct
FROM
  `dsar-performance-analysis.dsar_analysis.dsar_cases`
GROUP BY
  month_received
ORDER BY
  month_received;


-- 4. Root causes of SLA breaches
-- Ranks delay reasons among breached cases only.
SELECT
  delay_reason,
  COUNT(*) AS breached_cases
FROM
  `dsar-performance-analysis.dsar_analysis.dsar_cases`
WHERE
  sla_status = 'Breached'
GROUP BY
  delay_reason
ORDER BY
  breached_cases DESC;


-- 5. Impact of rework
-- Compares completion time and breach rate for cases with and without rework.
SELECT
  rework_required,
  COUNT(*) AS total_cases,
  ROUND(AVG(completion_days), 1) AS avg_completion_days,
  COUNTIF(sla_status = 'Breached') AS breached_cases,
  ROUND(100 * COUNTIF(sla_status = 'Breached') / COUNT(*), 1) AS breach_rate_pct
FROM
  `dsar-performance-analysis.dsar_analysis.dsar_cases`
GROUP BY
  rework_required
ORDER BY
  rework_required;
