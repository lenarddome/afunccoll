from fdfgen import forge_fdf
from subprocess import Popen, PIPE
import glob
import os

filenames = glob.glob('*.pdf')

newpath = r'./flatten' 
if not os.path.exists(newpath):
    os.makedirs(newpath)

fields = [("field1", "foo"),
          ("field2", "bar")]
fdf = forge_fdf("", fields, [], [], [])
for files in filenames:
    pdftk = ["pdf2ps", files, "-", "|",
              "ps2pdf", "-", "flatten/" + files]
    proc = Popen(pdftk, stdin=PIPE)
    output = proc.communicate(input=fdf)
    print(files)
    if output[1]: 
        raise IOError(output[1])
