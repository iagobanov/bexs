FROM python
EXPOSE 8000

ENV TZ="UTC" \
    ENV="development"

RUN mkdir /app
WORKDIR /app

ADD . /app
WORKDIR /app/src/frontend

RUN pip install -r requirements.txt

CMD python3 frontend.py