from flask import Flask, render_template
from flask_login import login_required, current_user
from secrets import token_urlsafe
from datetime import datetime
from routes.user_manager import user_bp, login_manager
from routes.event import event_bp
from models.event import Event
from models.user import User
from database import DataBase


app = Flask(__name__)
app.secret_key = token_urlsafe(16)
login_manager.init_app(app)

app.register_blueprint(user_bp, url_prefix="/user")
app.register_blueprint(event_bp, url_prefix="/event")


@app.route("/")  # index view placed here for best prati
@login_required
def home():
    with DataBase() as db:
        # event = [(id, arrangementAnsvarlig, tittel, tidspunkt, sted), (...), ...
        events = db.load_all_events()

        upcoming_events = [Event(*event)
                           for event in events if event[3] > datetime.now()]
        event_managers = []
        for event in upcoming_events:
            user = db.load_user(event.event_manager)
            event_managers.append(User(*user[:4]))

    return render_template('index.html', events=upcoming_events, event_managers=event_managers)


if __name__ == "__main__":
    app.run(debug=True)
