import os, sys, inspect

module_folder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile(inspect.currentframe()))[0], "lib")))
sys.path.append(module_folder)

import json, gobject
from flask import Flask, render_template

app = Flask(__name__, template_folder='./templates')

@app.route("/")
def index():
    return render_template('index.html')

