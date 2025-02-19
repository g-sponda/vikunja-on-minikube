from locust import HttpUser, task

class VikunjaUser(HttpUser):
    @task
    def root(self):
        self.client.get("/")

    @task
    def login(self):
        self.client.get("/login")

    @task
    def register(self):
        self.client.get("/register")

    @task
    def api_info(self):
        self.client.get("/api/v1/info")

    @task
    def api_metrics(self):
        self.client.get("/api/v1/metrics")

