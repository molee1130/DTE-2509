from flask_login import LoginManager, login_required, login_user, logout_user, current_user
from flask import Blueprint, render_template, request, url_for, redirect
from werkzeug.security import generate_password_hash, check_password_hash
from database import DataBase
from models.user import User

user_bp = Blueprint("user", __name__)
login_manager = LoginManager()

# set default view for unauthorized user.
# "user.login" ->  user = name of blueprint, login = name of view function 
login_manager.login_view = "user.login"   

#required for flask_login
@login_manager.user_loader
def load_user(user_id):
    with DataBase() as db:
        user = db.load_user(user_id)
    if user: 
        return User(user[0], user[1], user[2], user[3]) #id, s_name, l_name, email
    return None

@user_bp.route("/login", methods=["POST", "GET"])
def login():
    if request.method == "POST":
        email = request.form["email"]
        password = request.form["password"]

        with DataBase() as db:
            user = db.load_user_by_email(email)

            if user and check_password_hash(user[4], password): 
                login_user(User(user[0], user[1], user[2], user[3])) 
                return redirect(url_for("home"))

        return render_template("user/login.html", error = "Invalid credentials")
    return render_template("user/login.html")
    

    return True

@user_bp.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        s_name = request.form["s_name"]
        l_name = request.form["l_name"]
        email = request.form["email"]
        password = generate_password_hash(request.form["password"])

        with DataBase() as db:
            db.create_user(s_name, l_name, email, password)
        return redirect(url_for("user.login"))

    return render_template("user/register.html")

@user_bp.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("user.login"))

@user_bp.route("/profile")
@login_required
def profile():
    return render_template("user/profile.html", user = current_user)