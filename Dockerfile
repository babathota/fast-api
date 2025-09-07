#set the lisght image 
FROM python:3.12-slim AS base
#set working Dir  where code files exists 
WORKDIR /app

# copy requirements file and install dependencies
COPY requirements.txt .
# no-cache-dir to avoid caching and reduce image size
RUN pip install --no-cache-dir -r requirements.txt 


# Stage 2: Final runtime image takes the bulid packes to this 2 stage 
FROM python:3.12-slim

WORKDIR /app
# Copy installed packages from builder
COPY --from=base /usr/local /usr/local

# hey path  first check in .local/bin then in default path then got to next 
ENV PATH=/root/.local/bin:$PATH
# copy all the code files to the working dir calles /app  if put the .dockertighnotre leve those files will not be copied
COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]