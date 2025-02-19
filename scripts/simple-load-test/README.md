## How to

This simple load test uses locust(an open source performance/load testing tool for HTTP and other protocols) <https://github.com/locustio/locust>.
To use locust, I would recommend first to configure your virtualenv.

After configuring and activating virtualenv, install the needed libraries, with:

```
pip install -r requirements.txt
```

Enter on the directory that contains a file called `locustfile.py` and execute:

```
locust
```

This simple load test, makes only a get request to the following URIs:

- /
- /login
- /register
- /api/v1/info
- /api/v1/metrics
