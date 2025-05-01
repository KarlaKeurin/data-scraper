import pdfplumber
import pandas as pd
import os
import zipfile
from tqdm import tqdm

PDF_FILE = "downloads/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf"
CSV_FILE = "../arquivos/Teste_Karla.csv"
ZIP_FILE = "../arquivos/Teste_Karla.zip"

substituicoes = {
    "OD": "Odontológico",
    "AMB": "Ambulatorial"
}

def extract_table(pdf_file):
  all_data = []

  with pdfplumber.open(pdf_file) as pdf:
    for page in tqdm(pdf.pages, desc="Processando páginas"):
      tables = page.extract_tables()

      for table in tables:
        for row in table:
          all_data.append(row)
  
  return all_data

def save_pdf(data, csv_file):
  df = pd.DataFrame(data)

  if df.shape[1] > 1:
    df.columns = [f"Coluna_{i}" for i in range(df.shape[1])]
  
  df.replace(substituicoes, inplace=True)
  df.to_csv(csv_file, index=False, header=False)

def zip_files(csv_file, zip_file):
  with zipfile.ZipFile(zip_file, "w", zipfile.ZIP_DEFLATED) as zipf:
    zipf.write(csv_file, arcname=os.path.basename(csv_file))

if __name__ == "__main__":
  print("Extraindo tabelas do PDF...")
  data = extract_table(PDF_FILE)

  if data:
    print(f"Extraídas {len(data)} linhas. Salvando CSV...")
    save_pdf(data, CSV_FILE)

    print(f"Compactando CSV em {ZIP_FILE}")
    zip_files(CSV_FILE, ZIP_FILE)

    print(f"Processo concluído! Arquivo salvo como {ZIP_FILE}")
  else:
    print("Nenhuma tabela encontrada no PDF.")