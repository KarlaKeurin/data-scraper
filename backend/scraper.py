import os
import requests
import zipfile
from bs4 import BeautifulSoup
from tqdm import tqdm

URL = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

DOWNLOAD_DIR = "downloads"
ZIP_NAME = "anexos.zip"

os.makedirs(DOWNLOAD_DIR, exist_ok=True)

def get_pdf_links(url):
  response = requests.get(url)
  response.raise_for_status()

  soup = BeautifulSoup(response.text, "html.parser")
  pdf_links = []
  
  for link in soup.find_all("a", href=True):
    href = link["href"]
    if href.endswith(".pdf") and ("Anexo_I_" in href or "Anexo_II_" in href):
      pdf_links.append(href)
  
  return pdf_links

def download_pdf(pdf_links):
  for pdf_url in pdf_links:
    pdf_filename = pdf_url.split("/")[-1]
    pdf_path = os.path.join(DOWNLOAD_DIR, pdf_filename)

    response = requests.get(pdf_url, stream=True)
    total_size = int(response.headers.get("content-length", 0))

    with open(pdf_path, "wb") as file, tqdm(
      desc=pdf_filename,
      total=total_size,
      unit="B",
      unit_scale=True,
    ) as bar:
      for chunk in response.iter_content(1024):
        file.write(chunk)
        bar.update(len(chunk))

def zip_pdfs():
  with zipfile.ZipFile(ZIP_NAME, "w", zipfile.ZIP_DEFLATED) as zipf:
    for file in os.listdir(DOWNLOAD_DIR):
      zipf.write(os.path.join(DOWNLOAD_DIR, file), arcname=file)

if __name__ == "__main__":
  print("Buscando links dos PDFs...")
  pdf_links = get_pdf_links(URL)

  if not pdf_links:
    print("Nenhum PDF encontrado.")
  else:
    print(f"Encontrados {len(pdf_links)} PDFs. Iniciando download...")
    download_pdf(pdf_links)

    print("Compactando PDFs...")
    zip_pdfs()

    print(f"Arquivos compactados em {ZIP_NAME}")