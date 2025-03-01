from google.cloud import bigquery as bq
import logging
import pandas as pd
import os

from constants import tables_names, data_folder
from dotenv import load_dotenv

load_dotenv()

if __name__ == "__main__":
    logger = logging.getLogger("BQLoader")
    logging.basicConfig(filename="bqloader.log", level=logging.INFO)

    PROJECT_ID = os.getenv("GCLOUD_PROJECT_ID")
    DATASET_ID = os.getenv("DATASET_ID")

    logger.info("Initializing resources...")
    client = bq.Client(project=PROJECT_ID)
    dataset_ref = client.dataset(dataset_id=DATASET_ID)

    job_config = bq.LoadJobConfig(
        source_format=bq.SourceFormat.CSV,
        write_disposition=bq.WriteDisposition.WRITE_APPEND,
        skip_leading_rows=1,
    )

    for table in tables_names:
        logger.info("Creating BQ load job configs for '{table}'...")
        bq_table_name = table[:-4]
        file_path = f"{os.path.join(os.getcwd(),data_folder,table)}"

        df = pd.read_csv(file_path)
        table_ref = dataset_ref.table(bq_table_name)

        logger.info(f"Checking if the '{bq_table_name}' already exists...")
        try:
            client.get_table(table_ref)
        except Exception:
            logger.warning(f"Table '{bq_table_name}' not found, creating it...")
            schema = [bq.SchemaField(name, "STRING") for name in df.columns]
            table = bq.Table(table_ref, schema=schema)
            client.create_table(table)

        logger.info(f"Loading data from {table} into the a BigQuery table...")
        with open(file_path, "rb") as file:
            job = client.load_table_from_file(file, table_ref, job_config=job_config)
            job.result()

        logger.info(f"CSV data uploaded to {PROJECT_ID}.{DATASET_ID}.{bq_table_name}")
