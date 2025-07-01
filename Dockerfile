FROM python:3.13.5-alpine3.22

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Atualiza o pip e instala as dependências primeiro para aproveitar o cache do Docker
# Isso evita a reinstalação de dependências a cada alteração no código-fonte
COPY ellis-main/requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o código da aplicação para o diretório de trabalho
# Assumindo que o seu código está na pasta 'ellis-main' no contexto do build
COPY ellis-main/ .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]