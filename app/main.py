from fastapi import FastAPI

app: FastAPI = FastAPI()

@app.get("/")
def hello():
    return {"message to world": "Hello World I am Here"}