from flask import Flask, request, make_response, render_template, redirect, url_for

 
app = Flask(__name__, template_folder='templates')


@app.route("/")
# ex on using templates and values to use in templates
def index():
    myvalue = 'Morten'
    myresult = 10 + 20
    mylist = ['Dette', 'er', 'en', 'liste.']
    return render_template('index.html', myvalue = myvalue, myresult = myresult, mylist = mylist)

@app.route('/other')
def other():

    return render_template('other.html', word = 'Dette er baklengs', some_text = 'Some text in uppercase.')

#create your own filter to apply on variables in html file
@app.template_filter("reverse_string")
def reverse_string(s: str):
    return s[::-1]

#redirect endpoint
@app.route("/redirect_endpoint")
def redirect_endpoint():
    return redirect(url_for("other"))


@app.route("/hello", methods=["GET", 'POST'])
def hello():
    if request.method == 'GET':
        return 'You made a GET request'
    elif request.method == 'POST':
        return "You made a POST request"
    else:
        return "This message will never been seen" #because methods are decleard in decorater

@app.route("/greet/<name>") # bruke <name>
def greet(name):
     return f"Hello {name}"

@app.route("/add/<number1>/<number2>")
def add(number1, number2):
    return f"{number1} + {number2} = {number1 + number2}. --> arguments from url is str type"

#url parameters
@app.route("/handle_url_params")
def handle_params():
    greeting = request.args.get("greeting")
    name = request.args.get("name")
    return f"{greeting }, {name}"

@app.route('/request')
def request():
    response = make_response("Hello world")
    response.status_code = 202
    response.headers['content-type'] = 'plain-txt'
    return response  

if __name__ == "__main__":
    app.run(host='127.0.0.1', port='5555', debug=True)