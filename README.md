# PesaPap Growth Analytics

## Project Summary

This project analyses PesaPap transaction data to understand customer behaviour, product performance, transaction trends, and user conversion. It uses SQL, Python, pandas, SQLite, and statistical testing to support data-driven business decisions.

## Dataset Tables and Keys

| Table | Primary Key | Foreign Key |
|---|---|---|
| users | user_id | None |
| transactions | txn_id | user_id references users.user_id |
| experiment | user_id | user_id references users.user_id |

## Analysis Performed

- Data quality validation
- Product and county transaction performance
- Monthly transaction value and running totals
- Acquisition channel analysis
- Top users by transaction value
- Average transaction value by product
- Customer value tier segmentation
- Month-over-month active user analysis
- Customer RFM segmentation
- Cohort retention analysis
- A/B experiment conversion analysis
- Business impact estimation

## Tools Used

- Python
- pandas and NumPy
- SQLite and SQL
- SciPy
- Google Colab
- GitHub

## How to Run

1. Install the packages listed in `requirements.txt`.
2. Run `generate_data.py` to generate the datasets.
3. Open `pesapap_analysis.ipynb` in Google Colab or Jupyter Notebook.
4. Run the notebook cells in order to load the datasets, create the SQLite database, execute SQL queries, and perform the analysis.

## Headline Recommendation

Use the transaction, customer segmentation, retention, and A/B experiment results to guide growth decisions. Recommend adopting an experiment change only when the results support a meaningful improvement, and consider the confidence interval, statistical significance, and potential business impact.

## Project Files

- `generate_data.py` — dataset generator
- `requirements.txt` — Python dependencies
- `sql/queries.sql` — SQL analysis and validation queries
- `pesapap_analysis.ipynb` — data analysis notebook
- `reports/growth_memo.md` — business growth memo
