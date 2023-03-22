import requests
def handler(event, context):   
    response = requests.get("https://www.github.com/")
    print(response.text)
    return response.text
