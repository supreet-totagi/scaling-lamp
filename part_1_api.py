import requests

def make_call(offset):
    url = 'https://eservices.mas.gov.sg/api/action/datastore/search.json'
    resource_id = '3a5b732e-9490-4629-a398-d0c414204ee0'
    res = requests.get(url, params={'resource_id': resource_id, 'limit': 100, 'offset': offset}).json()
    return res

def get_records():
    url = 'https://eservices.mas.gov.sg/api/action/datastore/search.json'
    resource_id = '3a5b732e-9490-4629-a398-d0c414204ee0'

    weekly_results = {}
    first_page = make_call(0)
    weekly_results[first_page['result']['records'][0]['end_of_week']] = first_page['result']['records'][0]
    total_records = int(first_page['result']['total'])

    for offset in range(100, total_records, 100):
        res = make_call(offset)
        res_dict = {x['end_of_week']: x for x in res['result']['records']}
        weekly_results.update(res_dict)

    return weekly_results

records = get_records()
for key in records.keys():
    print(key)
