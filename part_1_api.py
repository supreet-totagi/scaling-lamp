import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

def make_call(offset):
    retry_strategy = Retry(
        total=3,
        backoff_factor=1,
        status_forcelist=[429, 500, 502, 503, 504],
        method_whitelist=['GET']
    )
    http = requests.Session()
    http.mount('https://', HTTPAdapter(max_retries=retry_strategy))

    url = 'https://eservices.mas.gov.sg/api/action/datastore/search.json'
    resource_id = '3a5b732e-9490-4629-a398-d0c414204ee0'

    try:
        r = http.get(url, params={'resource_id': resource_id, 'limit': 100, 'offset': offset})
        r.raise_for_status()
        if r.status_code == requests.codes.ok:
            return r.json()
    except requests.exceptions.RequestException as error:
    	print("Error: ", error)


def get_records():
    url = 'https://eservices.mas.gov.sg/api/action/datastore/search.json'
    resource_id = '3a5b732e-9490-4629-a398-d0c414204ee0'

    weekly_results = {}
    total_records = 0
    first_page = make_call(0)
    if first_page is not None:
        weekly_results[first_page['result']['records'][0]['end_of_week']] = first_page['result']['records'][0]
        total_records = int(first_page['result']['total'])

    for offset in range(100, total_records, 100):
        res = make_call(offset)
        res_dict = {x['end_of_week']: x for x in res['result']['records']}
        weekly_results.update(res_dict)

    return weekly_results

# records = get_records()
# for key in records.keys():
#     print(key)
