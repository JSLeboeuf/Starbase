import docx
import os

files = [
    "homme dominant (2).docx",
    "Ignorer et passer au contenu.docx",
    "NRC.docx",
    "Untitled document (10).docx"
]

for file_path in files:
    print(f"\n--- CONTENT OF {file_path} ---")
    try:
        if os.path.exists(file_path):
            doc = docx.Document(file_path)
            full_text = []
            for para in doc.paragraphs:
                full_text.append(para.text)
            print("\n".join(full_text))
        else:
            print(f"File not found: {file_path}")
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
    print(f"\n--- END OF {file_path} ---\n")

