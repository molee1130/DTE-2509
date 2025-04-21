
class Event:
    def __init__(self, id, event_manager, title, time, place, description): 
        self.id = id
        self.event_manager = event_manager
        self.title = title
        # mysql.connector automatically converts datetime datatype from mysql to datetime(python) object ? 
        self.time = time 
        self.place = place
        self.description = description
