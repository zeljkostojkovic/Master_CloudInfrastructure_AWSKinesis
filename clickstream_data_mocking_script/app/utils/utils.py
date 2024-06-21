import random
import uuid
from datetime import time, datetime

user_ids = [f"user_id_{number}" for number in range(1, 51)]
current_date = datetime.today()
actions = ["page-open", "page-closed",
           "checkout-start", "checkout-cancel",
           "product-view", "product-add-to-cart", "product-remove-from-cart"]
product_ids = [f"product_{number}" for number in range(1, 15)]
devices = ["desktop", "mobile", "tablet"]
browsers = ["Chrome", "Firefox", "Opera"]
desktop_and_tablet_resolutons = [(1920, 1080), (1366, 768), (1280, 720), (1024, 768)]
mobile_resolutions = [(640, 360), (800, 360), (915, 412)]


def generate_random_time():
    hour = random.randint(9, 21)  # Generate random time from 9 AM to 9 PM
    minute = random.randint(0, 59)
    second = random.randint(0, 59)
    return time(hour, minute, second)


def generate_page_details(action):
    if action in ["page-open", "page-closed"]:
        page = random.choice(["homepage", random.choice(product_ids)])
        return f"https://example.com/{page}", page.title()

    elif action in  ["product-view", "product-add-to-cart", "product-remove-from-cart"]:
        page = random.choice(product_ids)
        return f"https://random-web-site.com/{page}", page.title()

    elif action in ["checkout-start", "checkout-cancel"]:
        return "https://example.com/checkout-page", "Checkout Page"


def generate_device_details():
    device = random.choice(devices)
    browser = random.choice(browsers)
    browser_version = "127.0" if browser == "Chrome" else "126.0.1" if browser == "Firefox" else "110.0"
    if device in ["desktop", "tablet"]:
        resolution_width, resolution_height = random.choice(desktop_and_tablet_resolutons)
    else:
        resolution_width, resolution_height = random.choice(mobile_resolutions)

    return {
        "type": device,
        "browser": {
            "name": browser,
            "version": browser_version
        },
        "resolution": {
            "width": resolution_width,
            "height": resolution_height
        }
    }


def generate_click_stream_data():
    random_action = random.choice(actions)
    page_url, page_title = generate_page_details(random_action)

    return {
        "user_id": random.choice(user_ids),
        "session_id": str(uuid.uuid4()),
        "date": current_date.strftime("%Y-%m-%d"),
        "timestamp": datetime.combine(current_date, generate_random_time()).strftime("%Y-%m-%d %H:%M:%S"),
        "action": random.choice(actions),
        "page": {
            "url": page_url,
            "title": page_title
        },
        "device": generate_device_details()
    }
