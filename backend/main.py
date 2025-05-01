from fastapi import FastAPI, Query
from fastapi.middleware.cors import CORSMiddleware
import pandas as pd
from unidecode import unidecode

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5175"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

df = pd.read_csv("../arquivos/operadoras_de_plano_de_saude_ativas/Relatorio_cadop.csv", sep=";")

df['Nome_Fantasia'] = df['Nome_Fantasia'].astype(str).str.strip()
df['Razao_Social'] = df['Razao_Social'].astype(str).str.strip()

df['Busca'] = df.apply(lambda row: row['Nome_Fantasia'] if pd.notna(row['Nome_Fantasia']) and row['Nome_Fantasia'].lower() != 'nan' and row['Nome_Fantasia'] != '' else row['Razao_Social'], axis=1)

df['Busca_Sem_Acento'] = df['Busca'].apply(lambda x: unidecode(x.lower()) if isinstance(x, str) else x)

@app.get("/buscar")
def buscar_operadora(nome: str = Query(..., description="Nome da operadora")):
    nome_sem_acento = unidecode(nome.strip().lower())
    resultado = df[df['Busca_Sem_Acento'].str.contains(nome_sem_acento, na=False)]
    return resultado.drop(columns=['Busca_Sem_Acento', 'Busca']).fillna("").to_dict(orient='records')