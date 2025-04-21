from flask import Blueprint, render_template, request, flash, redirect, url_for
from flask_login import current_user, login_required
from datetime import datetime
from database import DataBase
from models.event import Event

event_bp = Blueprint("event", __name__)


@event_bp.route("/event_info/<int:event_id>")
@login_required
def event_info(event_id):
    with DataBase() as db:
        user_alredy_joined = db.is_user_registered(current_user.id, event_id)
        participants = db.get_participants_by_event_id(event_id)

        event_manager = db.get_event_manager_name(event_id)
        event_manager = f"{event_manager[0]} {event_manager[1]}"

        event = Event(*db.get_event_by_event_id(event_id))

    return render_template("event/event_info.html", participants=participants,
                           event_manager=event_manager, event_id=event_id,
                           user_alredy_joined=user_alredy_joined, event=event)

@event_bp.route("/registration_or_deregistration/<int:event_id>", methods=["POST"])
def registration_or_deregistration(event_id):
    with DataBase() as db:
        user_alredy_joined = db.is_user_registered(current_user.id, event_id)
        if not user_alredy_joined:
            db.add_user_to_event(event_id, current_user.id)
        else:
            db.delete_user_from_event(event_id, current_user.id)
    return redirect(url_for("event.event_info", event_id=event_id))


@event_bp.route("/create_event", methods=["GET", "POST"])
@login_required
def create_event():
    if request.method == "POST":

        title = request.form.get("event_title")
        place = request.form.get("event_place")
        time = datetime.strptime(request.form.get("event_time"),"%Y-%m-%dT%H:%M")
        description = request.form.get("event_description")

        with DataBase() as db:
            db.add_event(current_user.id, title, time, place, description)
        return redirect(url_for("home"))

    return render_template("event/create_event.html")

@event_bp.route("/your_events")
@login_required
def your_events():
    with DataBase() as db:
        events = db.get_event_by_event_manager(current_user.id)
    events = [Event(*event) for event in events]

    return render_template("event/your_events.html", events=events)

@event_bp.route("/edit_event/<int:event_id>", methods=["POST", "GET"])
@login_required
def edit_event(event_id):
    if request.method == "POST":
        title = request.form.get("event_title")
        place = request.form.get("event_place")
        time = datetime.strptime(request.form.get("event_time"),"%Y-%m-%dT%H:%M")
        description = request.form.get("event_description")

        with DataBase() as db:
            db.update_event(event_id, title, time, place, description)
        return redirect(url_for("event.your_events"))

    with DataBase() as db:
        event = Event(*db.get_event_by_event_id(event_id))
    
    return render_template("event/edit_event.html", event=event)

@event_bp.route("/delete_event/<int:event_id>", methods=["POST","GET"])
@login_required
def delete_event(event_id):
    with DataBase() as db:
        db.delete_event_by_event_id(event_id)
    return redirect(url_for("event.your_events"))
