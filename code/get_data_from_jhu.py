#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas
import matplotlib
from matplotlib import pyplot as plt
import os

# Load JHU data

## Update
os.system("git submodule update --recursive")

jhu_data_raw = pandas.read_csv("../JHU_data/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
cases_germany = jhu_data_raw[jhu_data_raw["Country/Region"]=="Germany"].iloc[:,-15:].values[0]
cases_world = jhu_data_raw.iloc[:,-15:].sum()
dates = cases_world.index
germany_vs_world = [{"Germany":g, "World":w} for g,w in zip(cases_germany, cases_world.values)]
data_for_sim = pandas.DataFrame(index=dates, columns=["Germany","World"], data=germany_vs_world, )
data_for_sim.set_index(data_for_sim.index.rename("Date"),inplace=True)
data_for_sim.to_csv("Incidence.csv")


# In[ ]:




