from app import create_app
# can not directly import (flask, sqlalchemy etc?). Will cause circular import statments
# therefor we call create_app, who then use the imports  
flask_app = create_app()

if __name__ == "__main__":
    flask_app.run(host="0.0.0.0", debug=True)