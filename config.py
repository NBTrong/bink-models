import requests

def get_network_id():
    url = "https://api.zerotier.com/api/v1/network"
    headers = {
        "Authorization": "token nhQgBCDke5G5fpcNng80OgPXN1crmtkw"
    }
    response = requests.get(url, headers=headers)
    networks = response.json()
    network_list = []
    for network in networks:
        network_id = network["id"]
        network_name = network["config"]["name"]
        network_list.append((network_id, network_name))

    return network_list[0][0]

def main(): 
    network_id = get_network_id()
    with open("data.json", "w") as f:
        f.write(f'{{"network_id": "{network_id}"}}')

if __name__ == "__main__":
    main()