import base64
import requests
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn

@keyword(name = "Login To Spotify")
def login(client_id, client_secret):
    base_url = "https://accounts.spotify.com/"
    endpoint = "api/token"
    full_url = base_url + endpoint
    unencoded_client_creds = f"{client_id}:{client_secret}"
    encoded_client_creds = base64.b64encode(unencoded_client_creds.encode()).decode()
    response = requests.post(full_url,
                    data={"grant_type": "client_credentials"},
                    headers={"Content-Type": "application/x-www-form-urlencoded",
                             "Authorization": f"Basic {encoded_client_creds}"}
                    )
    token = response.json()["access_token"]
    BuiltIn().set_global_variable("${TOKEN}", token) #zapisanie jako zmienna globalna, do zapytań
    return token


@keyword(name="List Songs From Search")
def list_songs_from_search(query):
    base_url = "https://api.spotify.com"
    endpoint = "/v1/search"
    full_url = base_url + endpoint
    token = BuiltIn().get_variable_value("${TOKEN}")
    response = requests.get(full_url,
                            params={"q": query,
                                    "type": "track"},
                            headers={"Accept": "application/json",
                                     "Content-Type": "application/json",
                                     "Authorization": f"Bearer {token}"
                                     }
                            )
    items = response.json()["tracks"]["items"]
    tracks = []
    for item in items:

    return response.json()
