import json
import openai
import sqlite3

# Load the API key from the JSON file
with open("config.json", "r") as config_file:
    config = json.load(config_file)

# Set the OpenAI API key
openai.api_key = config["OPENAI_API_KEY"]

# Connect to SQLite database
conn = sqlite3.connect("gaming_tournament.db")
cursor = conn.cursor()

def ask_gpt(question):
    # Define the schema to help GPT generate SQL
    schema = """
    Tables: User, Team, Game, Tournament, TeamMembership, TournamentResults, Match, Message

    Columns:
    - User: user_id, username, email, join_date, skill_level
    - Team: team_id, team_name, created_date, captain_id
    - Game: game_id, game_name, genre, release_year
    - Tournament: tournament_id, game_id, tournament_name, start_date, end_date, prize_pool
    - TeamMembership: team_id, user_id, joined_date
    - TournamentResults: tournament_id, team_id, placement, prize_money
    - Match: match_id, tournament_id, team1_id, team2_id, match_date, winner_team_id
    - Message: message_id, team_id, user_id, message_content, sent_at
    """
    
    # GPT prompt
    prompt = f"""
    Database schema:
    {schema}

    User question: "{question}"
    SQL query:
    """

    # Generate SQL query using GPT
    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "You are a helpful assistant skilled at generating SQL queries based on database schemas."},
            {"role": "user", "content": prompt},
        ],
        max_tokens=150,
        temperature=0
    )

    # Extract the SQL query from the response and clean it
    sql_query = response['choices'][0]['message']['content'].strip()
    if sql_query.startswith("```") and sql_query.endswith("```"):
        sql_query = sql_query[sql_query.find("\n")+1:sql_query.rfind("\n")].strip()
    return sql_query

# Example usage
user_question =  "Which users have sent messages but never participated in a tournament?"
sql_query = ask_gpt(user_question)
print(f"Generated SQL Query: {sql_query}")

# Execute the SQL query
try:
    cursor.execute(sql_query)
    results = cursor.fetchall()
    print("Results:")
    for row in results:
        print(row)
except sqlite3.Error as e:
    print(f"SQLite Error: {e}")
    print(f"Problematic Query: {sql_query}")
except Exception as e:
    print(f"Error: {e}")

# Close the connection
conn.close()