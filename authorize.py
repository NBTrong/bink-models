import requests

# Get network ID from data.json
network_id = None
with open("data.json", "r") as f:
  data = f.read()
  # Convert json string to dictionary
  data = eval(data)
  network_id = data["network_id"]
base_url = "https://api.zerotier.com/api/v1"
headers = {
    "Authorization": "token nhQgBCDke5G5fpcNng80OgPXN1crmtkw"
}

def get_network_members():
  url = f"{base_url}/network/{network_id}/member"
  response = requests.get(url, headers=headers)
  return response.json()

def authorize_network_members(members):
  url = f"{base_url}/network/{network_id}/member"
  for member in members:
    if not member["config"]["authorized"]:
      member_id = member["nodeId"]
      payload = {
          "hidden": False,
          "config": {
              "authorized": True
          }
      }
      print(f"Authorizing member with ID {member_id}")
      print(member, member["config"]["authorized"])
      response = requests.post(f"{url}/{member_id}", json=payload, headers=headers)
      print(f"Authorized member with ID {member_id}")
      print(response.json())

members = get_network_members()

authorize_network_members(members)

members = get_network_members()