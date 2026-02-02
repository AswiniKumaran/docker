FROM python:3.10
ENV PYTHONDONTWRITEBYTECODE = 1
ENV PYTHONBUFFERED = 1
WORKDIR app/
COPY . .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8000
RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
