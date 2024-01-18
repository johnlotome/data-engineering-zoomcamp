#!/usr/bin/env python
# coding: utf-8

import os
import argparse

from time import time
from config import settings

import pandas as pd
from sqlalchemy import create_engine


def ingest_data():
    user = settings.postgres_user
    password = settings.postgres_password
    host = settings.db_host
    port = settings.port
    db = settings.postgres_db
    table_name = settings.table_name
    url = settings.url
    zip_csv_path = 'output.csv.gz'
    file_path = 'output.csv'

    os.system(f"wget {url} -O {zip_csv_path}  && gunzip -f {zip_csv_path}")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df_iter = pd.read_csv(file_path, iterator=True, chunksize=100000)

    df = next(df_iter)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.to_sql(name=table_name, con=engine, if_exists='append')


    while True: 

        try:
            t_start = time()
            
            df = next(df_iter)

            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

            df.to_sql(name=table_name, con=engine, if_exists='append')

            t_end = time()

            print('inserted another chunk, took %.3f second' % (t_end - t_start))

        except StopIteration:
            print("Finished ingesting data into the postgres database")
            break

if __name__ == '__main__':
    ingest_data()
   