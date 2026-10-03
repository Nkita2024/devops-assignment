from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "message": "DevOps Assignment Application",
        "status": "running"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/db-check")
def db_check():
    try:
        conn = psycopg2.connect(
            host=os.environ["DB_HOST"],
            port=os.getenv("DB_PORT", "5432"),
            dbname=os.environ["DB_NAME"],
            user=os.environ["DB_USER"],
            password=os.environ["DB_PASSWORD"],
            connect_timeout=3
        )
        conn.close()
        return jsonify({"database": "connected"}), 200
    except Exception:
        return jsonify({"database": "unavailable"}), 503

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
