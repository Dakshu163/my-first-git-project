import argparse
import os

from confluent_kafka import Producer


def main():
    parser = argparse.ArgumentParser(description='Send a text file to Kafka')
    parser.add_argument('file', help='path of the text file to send')
    parser.add_argument('--topic', default='file-topic')
    parser.add_argument('--bootstrap', default='localhost:9092')
    args = parser.parse_args()

    producer = Producer({'bootstrap.servers': args.bootstrap})
    key = os.path.basename(args.file)
    failed = 0

    def on_delivery(err, msg):
        nonlocal failed
        if err is not None:
            failed += 1
            print(f'Delivery failed: {err}')

    count = 0
    with open(args.file, 'r', encoding='utf-8') as f:
        for line in f:
            value = line.rstrip('\r\n')
            while True:
                try:
                    producer.produce(args.topic, key=key, value=value,
                                     callback=on_delivery)
                    break
                except BufferError:
                    producer.poll(1)
            count += 1
            producer.poll(0)

    producer.flush()
    print(f'Sent {count - failed} of {count} lines from {args.file} to topic {args.topic}')


if __name__ == '__main__':
    main()