import os
from flask import Flask, render_template, request, redirect, url_for, flash, session
from werkzeug.utils import escape
import mysql.connector
from dotenv import load_dotenv
import bcrypt
import random

# Load environment variables from .env file
load_dotenv()

# Initialize the flask app
app = Flask(__name__)
app.secret_key = os.getenv("SECRET")

# ------------------------ BEGIN FUNCTIONS ------------------------ #
# Function to retrieve DB connection
def get_db_connection():
    conn = mysql.connector.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_DATABASE")
    )
    return conn
# ------------------------ END FUNCTIONS ------------------------ #


# ------------------------ BEGIN ROUTES ------------------------ #
# HOME GET REQUEST
@app.route("/", methods=["GET"])
def home():
    return render_template("index.html") # Return the page to be rendered

#LOGIN ROUTE THAT TAKES GET AND POST REQUESTS
@app.route("/login", methods=["GET", "POST"])
def login_page():
    if request.method == "POST":
        #RETRIEVE FORM DATA
        login_valid = False
        data = request.form
        username = data["username"]
        password = data["password"]
        #GET THE PASSWORD HASH FROM THE DATABASE AND CHECK IT AGAINST THE ENTERED PASSWORD TO SEE IF IT'S CORRECT
        conn=get_db_connection()
        cursor=conn.cursor()
        cursor.execute("SELECT password FROM USERS WHERE Username = %s", (username,))
        hash = cursor.fetchall()
        if hash and bcrypt.checkpw(password.encode("utf8"), hash[0][0].encode("utf8")):
            session["username"] = username
            flash("Login Successful!", "success")
            return redirect(url_for("characters"))
        #IF PASSWORD IS INCORRRECT OR THERE'S NO USER REGISTERED UNDER THE NAME
        flash("Incorrect Username or Password", "error")
        return render_template("login.html")
    #HANDLES SERVING THE PAGE
    if request.method == "GET":
        return render_template("login.html")

#LOGOUT ROUTE THAT HANDLES LOGGING OUT
@app.route("/logout", methods=["GET"])
def log_out():
    #REMOVE THE USERNAME FROM THE COOKIE IF IT EXISTS
    session.pop("username", None)
    return redirect(url_for("home"))

#REGISTRATION ROUTE
@app.route("/register", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        data = request.form
        #GET FORM DATA
        username=data["username"]
        password=data["password"]
        repeatPassword=data["repeatpassword"]
        #CHECKS TO SEE IF PASSWORD AND REPEAT PASSWORD ARE THE SAME, OTHERWISE IT JUST REDIRECTS TO THE PAGE
        if password == repeatPassword:
            conn=get_db_connection()
            cursor=conn.cursor()
            #ENFORCE UNIQUENESS OF USERNAMES
            cursor.execute("SELECT * FROM USERS WHERE Username = %s", (username,))
            if len(cursor.fetchall()) != 0:
                flash("Username already taken.")
                return render_template("register.html")
            #SALT AND HASH THE PASSWORD, GENERATE USER ID BEFORE THROWING IT IN THE DATABASE
            hash=bcrypt.hashpw(password.encode("utf8"), bcrypt.gensalt()).decode("utf8")
            id = random.randint(0,9223372036854775807*2)
            cursor.execute("INSERT INTO dnd_character_creator.USERS (Username, Password, IsAdmin, userID) VALUES (%s, %s, 0, %s);", (escape(username), hash, id))
            conn.commit()
            conn.close()
            flash("Registered successfully!", "success")
            return redirect(url_for("login_page"))
        else:
            flash("Password must be the same as the repeat password.", "error")
            return render_template("register.html")
    if request.method == "GET":
        return render_template("register.html")

#CHARACTER VIEW THAT SHOWS CHARACTERS, REDIRECTS IF NOT LOGGED IN.
@app.route("/characterview", methods=["GET"])
def characters():
    if "username" in session:
        conn=get_db_connection()
        cursor=conn.cursor()
        #GET DATA FROM THE VIEW THAT IS RELEVANT
        stmt = cursor.execute("select * from dnd_character_creator.CHARACTERVIEW where Username = %s", (session["username"],))
        characterList = cursor.fetchall()
        return render_template("characterview.html", characterList=characterList)
    return redirect(url_for("login_page"))

#CHARACTER CREATION ROUTE, TAKES GET AND POST, RENDERS PAGE FOR GET AND INSERTS CHARACTER INTO DB FOR POST, REDIRECTS IF NOT LOGGED IN.
@app.route("/charactercreate", methods=["GET", "POST"]) #TODO: ADD FUNCTIONALITY FOR THE DELETE AND UPDATE FUNCTIONS
def characterCreate():
    if "username" not in session:
        return redirect(url_for("login_page"))
    if request.method == "GET":
        flash("Not Logged In.", "error")
        return render_template("charactercreator.html")
    if request.method == "POST":
        #GET FORM DATA(ALL OF IT)
        data = request.form
        firstname = data["FirstName"]
        lastname = data["LastName"]
        creationdate = data["CreationDate"]
        proficiencies = data["Proficiencies"]
        traits = data["Traits"]
        languages = data["Languages"]
        hitpoints = data["HitPoints"]
        background = data["Background"]
        classname = data["className"]
        race = data["Race"]
        #INSERT CHARACTER INTO THE DATABASE
        characterID = random.randint(0,9223372036854775807*2)
        conn=get_db_connection()
        cursor=conn.cursor()
        stmt = cursor.execute("select UserID from USERS where username = %s;", (session["username"],))
        userID = cursor.fetchall()
        cursor.execute("INSERT INTO dnd_character_creator.CHARACTERS(FirstName,LastName,CreationDate,Proficiencies,Traits,Languages,HitPoints,UserID,RaceID,BackgroundID,ClassID,CharacterID) VALUES(%s,%s,%s,%s,%s,%s,%s,%s,(SELECT BackgroundID from BACKGROUND where BackgroundName = %s),(SELECT ClassID from CLASS where ClassName = %s),(SELECT RaceID from RACE where RaceName = %s),%s);", \
                        (firstname, lastname,creationdate,proficiencies,traits,languages,hitpoints,userID[0][0],background,classname,race,characterID))
        conn.commit()
        conn.close()
        #REDIRECT TO THE CHARACTER VIEW PAGE
        return redirect(url_for("characters"))
    if request.method == "UPDATE":
        pass #TODO: ADD UPDATE FUNCTIONALITY
    if request.method == "DELETE":
        pass #TODO: ADD CHARACTER DELETION FUNCTIONALITY
    

# ------------------------ END ROUTES ------------------------ #


# listen on port 80
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80, debug=False) # WHEN TESTING BE SURE TO TURN THIS ON, WHEN ON PRODUCTION BE COMPLETELY SURE TO TURN THIS OFF
    #IT MAY HAVE A KEY PIN FOR THE CODE EXECUTION, BUT THAT CAN BE REVERSE ENGINEERED IF THEY HAVE ANY KIND OF LOCAL FILE INCLUSION
    #RESULTING IN REMOTE CODE EXECUTION AND THAT'S REALLY BAD FOR EVERYONE INVOLVED BUT THE HACKER