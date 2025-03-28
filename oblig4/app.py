from flask import Flask, render_template
import secrets

app = Flask(__name__)
app.secret_key = secrets.token_urlsafe(16)

@app.route("/")
def index():
    return render_template("index.html", title="Hjem")

@app.route("/flask_info")
def flask_info():
    return render_template("flask_info.html", title="Flask Informasjon")

@app.route("/myself_info")
def myself_info():
    return render_template("myself_info.html", title="Om Meg")

if __name__ == "__main__":
    app.run(debug=True)

