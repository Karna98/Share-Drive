from app import create_app
from os import path

if __name__ == "__main__":
    app =  app=create_app()

    # Check if db.sqlite file exists or not. If not then create db.sqlite
    if not path.exists("app/db.sqlite"):
        print ("<------------>")
        print("Setting up Database ..")
        print ("<------------>")
        print()
        import db
        db.create_all(app) 
        print ("<------------>")
        print("Database Setup Completed ..")
        print ("<------------>")
        print()
        
    app.run(host ='0.0.0.0', port = 5001, debug = True)