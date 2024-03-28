import ray
from ray import serve
from fastapi import FastAPI

from transformers import pipeline

app = FastAPI()


@serve.deployment(num_replicas=1)
@serve.ingress(app)
class Mistral:
    def __init__(self):
      # Load model
      self.model = pipeline("text-generation", model="mistralai/Mistral-7B-Instruct-v0.2")

    @app.post("/")
    async def generate(self, text: str) -> str:
      # Run inference for text generation
      model_output = self.model(text, max_length=50, num_return_sequences=1)

      # Post-process output to return only the generated text
      generated_text = model_output[0]["generated_text"]

      return {"generated_text": `generated_text`}


app = Mistral.bind()
