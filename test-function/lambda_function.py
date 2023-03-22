import requests
def lambda_function(event, context):   
    response = requests.get("https://www.github.com/")
    print(response.text)
    return response.text
