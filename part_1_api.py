import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

def make_call(offset):
    """
    Helper function to make HTTP call to MAS API.

    :param offset:  Number of rows to offset in the returned results.
    :return: JSON response from the API or None.
    """

    # Retry strategy to account for failures related to network connections or server-side errors
    retry_strategy = Retry(
        total=3,
        backoff_factor=1,
        status_forcelist=[429, 500, 502, 503, 504],
        method_whitelist=['GET']
    )
    http = requests.Session()
    http.mount('https://', HTTPAdapter(max_retries=retry_strategy))

    # URL and Resource Id for our use-case
    url = 'https://eservices.mas.gov.sg/api/action/datastore/search.json'
    resource_id = '3a5b732e-9490-4629-a398-d0c414204ee0'

    # Catch exceptions but do not exit
    try:
        r = http.get(url, params={'resource_id': resource_id, 'limit': 100, 'offset': offset})
        r.raise_for_status()
        return r.json()
    except requests.exceptions.RequestException as error:
    	print("Error: ", error)

def get_records():
    """
     Function to fetch weekly historical exchange rate from MAS as far back as 1988 till present day.

    :return: Dict with `end_of_week` attribute as key and corresponsing exchange rate for the week as value.
    """

    weekly_results = {}
    total_records = 0

    # Fetch first page of records
    first_page = make_call(0)
    if first_page is not None:
        weekly_results = {x['end_of_week']: x for x in first_page['result']['records']}
        total_records = int(first_page['result']['total'])

    # Fetch rest of the pages based on total_records retrived from first page
    for offset in range(100, total_records, 100):
        res = make_call(offset)
        res_dict = {x['end_of_week']: x for x in res['result']['records']}
        weekly_results.update(res_dict)

    return weekly_results

records = get_records()
