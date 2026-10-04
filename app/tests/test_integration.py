import requests


def test_application_is_running():
    response = requests.get("http://localhost:5000/health")

    assert response.status_code == 200

