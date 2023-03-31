import requests
def handler(event, context):   
    response = requests.get("https://www.docker.com/")
    print(response.text)
    return response.text
