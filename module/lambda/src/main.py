import json
import random
from datetime import datetime

def lambda_handler(event, context):
    # List of cloud-related quotes
    quotes = [
        "The cloud is about how you do computing, not where you do computing. - Paul Maritz",
        "Cloud is about elasticity, agility, and automation. - Satya Nadella",
        "The cloud is the future of business technology. - Marc Benioff",
        "There is no cloud, it's just someone else’s computer. - Unknown",
        "Move to the cloud, but do it wisely. - Werner Vogels",
        "Cloud computing is empowering. - Jeff Bezos"
    ]

    # Get the current date and time
    current_date = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')

    # Select a random quote
    random_quote = random.choice(quotes)

    # Build the response
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps({
            'message': 'Current date and time',
            'date': current_date,
            'quote': random_quote
        })
    }
