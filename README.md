# COVID-19 Trends — Serbia, Norway, Germany (BigQuery + Python)

A short, clean, **reproducible** analysis of COVID-19 trends for **Serbia, Norway, Germany**.

- **Local / Python**: OWID data → Pandas → plots  
- **Cloud / SQL**: BigQuery SQL (window functions) → tables/plots

## Figures
<p align="center">
  <img src="outputs/plots/new_cases_ma7.png" width="48%" />
  <img src="outputs/plots/incidence_per_100k_ma7.png" width="48%" /><br/>
  <img src="outputs/plots/top10_bar.png" width="48%" />
  <img src="outputs/plots/peak_ma7_bar.png" width="48%" />
</p>

> *Why this is useful:* per-capita normalization + MA7 smoothing and weekly views make cross-country comparisons clearer and reduce daily noise.

---

## What this project does
- **Local (Python)**  
  - Fetch OWID directly from URL (no manual download)  
  - MA7 smoothing, per-100k normalization, weekly aggregation  
  - Identify peaks (local maxima / top values)
- **BigQuery (SQL)**  
  - MA7 of new cases, incidence per 100k, Top-10 by date, peak dates  
  - Uses window functions (`LAG`, `AVG OVER`, `DENSE_RANK`)

---

## How to run

### Local notebook (OWID)
```bash
pip install -r requirements.txt
gcloud auth application-default login   # this is needed only if you also run the BQ cells
jupyter lab