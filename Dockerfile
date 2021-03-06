FROM python:3.8.2

RUN apt update && \
    apt install -y python3-dev gcc

WORKDIR app 
# Install pytorch and fastai
#RUN pip install torch_nightly -f https://download.pytorch.org/whl/nightly/cpu/torch_nightly.html

RUN pip install --upgrade pip


ADD requirements.txt .
RUN pip install -r requirements.txt
#pip install --no-cache-dir -r
ADD src/models models
ADD src src

#ADD main.py .
#ADD config.yaml .

# Run it once to trigger resnet download
RUN python src/main.py prepare

#EXPOSE 5000

# Start the server
CMD ["python", "src/main.py", "serve"]
