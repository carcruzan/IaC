import requests
def handler(event, context):   
    response = requests.get("https://www.google.com/")
    print(response.text)
    return response.text
