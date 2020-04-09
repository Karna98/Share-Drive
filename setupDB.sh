#!/usr/bin/env python3
from app import db, create_app
# pass the create_app result so Flask-SQLAlchemy gets the configuration.
db.create_all(app=create_app())