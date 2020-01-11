import json
with open('./Data/all.json') as json_file:
    alldata = json.load(json_file)
import pandas
df = pandas.DataFrame.from_dict(alldata[3])
dicts = [x for x in alldata if isinstance(x, dict)]
print(dicts[5])

