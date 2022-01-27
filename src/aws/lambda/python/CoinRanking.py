import requests
from funcy import omit

def handler(event, context):
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100000&page=1&sparkline=false&price_change_percentage=24h"
    response = requests.get(url)
    coins = response.json()
    sorted_coins = sorted(coins, key=lambda coin: coin.get('price_change_percentage_24h_in_currency', 0), reverse=True)
    filtered_coins = [{"symbol": x["symbol"], "pct_change": x["price_change_percentage_24h_in_currency"]} for x in sorted_coins]
    return {
        'top_coins': filtered_coins[:10],
        'bottom_coins': filtered_coins[-10:],
    }
