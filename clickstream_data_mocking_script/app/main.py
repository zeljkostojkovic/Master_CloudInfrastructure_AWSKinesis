import os
import time
import json
import boto3
import logging

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
logging.getLogger('botocore').setLevel(logging.CRITICAL)
logging.getLogger()

from utils.utils import generate_click_stream_data

kinesis_client = boto3.client("kinesis")
kinesis_data_stream = os.getenv("AWS_KINESIS_STREAM_NAME")

if __name__ == "__main__":
    logging.info("Starting the script.")
    number_of_records_sent = 0
    chunk_size = 50
    while True:
        click_stream_events = [generate_click_stream_data() for _ in range(chunk_size)]
        response = kinesis_client.put_records(
            StreamName=kinesis_data_stream,
            Records=[
                {
                    "Data": json.dumps(event),
                    "PartitionKey": "random_partition_key"
                } for event in click_stream_events
            ]
        )
        number_of_records_sent += chunk_size
        time.sleep(5)

        if number_of_records_sent == 1000:
            logging.info("Sent 1000 records. Exiting the program.")
            break

        if number_of_records_sent % 100 == 0:
            logging.info(f"Sent {number_of_records_sent} records to AWS Kinesis Data Stream {kinesis_data_stream}.")
            time.sleep(60)

