import pandas as pd

def parse_stata_chunk(chunk):
    import os
    # if file does not exist write header
    df = pd.DataFrame()
    df = df.append(chunk, ignore_index=True)
    print(df.head(2))
    if not os.path.isfile('BES2017_W13_Panel_v1.0.csv'):
        df.to_csv('BES2017_W13_Panel_v1.0.csv',header ='column_names')
    else: # else it exists so append without writing the header
        df.to_csv('BES2017_W13_Panel_v1.0.csv',mode = 'a',header=False)

i = 0
itr = pd.read_stata('./BES2017_W13_Panel_v1.0.dta', chunksize=1000,  iterator=True)
for chunk in itr:
    i = i+1
    print('done items: ')
    print(i)
    parse_stata_chunk(chunk)
