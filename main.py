import pandas as pd
import requests
import xml.etree.ElementTree as ET
from xml.dom import minidom
import time
import sys
import os
from dotenv import load_dotenv

load_dotenv()

# OMDb API key - get from http://www.omdbapi.com/apikey.aspx
API_KEY = os.getenv('OMDB_API_KEY')
API_URL = "http://www.omdbapi.com/"
DEMO_MODE = False  # Set to False once you have a valid API key

def get_movie_data(title, year):
    """Fetch movie data from OMDb API or use demo data"""
    if DEMO_MODE:
        return get_demo_data(title, year)
    
    params = {
        't': title,
        'y': str(year),
        'apikey': API_KEY,
        'type': 'movie'
    }
    try:
        response = requests.get(API_URL, params=params, timeout=10)
        if response.status_code == 200:
            data = response.json()
            if data.get('Response') == 'True':
                return {
                    'imdb_rating': data.get('imdbRating', 'N/A'),
                    'actors': data.get('Actors', 'N/A'),
                    'imdb_votes': data.get('imdbVotes', 'N/A').replace(',', '') if data.get('imdbVotes') else 'N/A'
                }
            else:
                print(f"Movie not found: {title} ({year})")
                return {'imdb_rating': 'N/A', 'actors': 'N/A', 'imdb_votes': 'N/A'}
        else:
            print(f"Error fetching data for {title} ({year}): {response.status_code}")
            return {'imdb_rating': 'N/A', 'actors': 'N/A', 'imdb_votes': 'N/A'}
    except Exception as e:
        print(f"Exception for {title} ({year}): {str(e)}")
        return {'imdb_rating': 'N/A', 'actors': 'N/A', 'imdb_votes': 'N/A'}

def get_demo_data(title, year):
    """Return sample movie data for demonstration purposes"""
    demo_data = {
        'The Shawshank Redemption': {'imdb_rating': '9.3', 'actors': 'Tim Robbins, Morgan Freeman', 'imdb_votes': '2600000'},
        'The Godfather': {'imdb_rating': '9.2', 'actors': 'Marlon Brando, Al Pacino', 'imdb_votes': '1700000'},
        'The Dark Knight': {'imdb_rating': '9.0', 'actors': 'Christian Bale, Heath Ledger', 'imdb_votes': '2600000'},
        'Pulp Fiction': {'imdb_rating': '8.9', 'actors': 'John Travolta, Uma Thurman', 'imdb_votes': '1800000'},
        'Inception': {'imdb_rating': '8.8', 'actors': 'Leonardo DiCaprio, Marion Cotillard', 'imdb_votes': '2300000'},
        'Forrest Gump': {'imdb_rating': '8.8', 'actors': 'Tom Hanks, Robin Wright', 'imdb_votes': '1800000'},
        'The Matrix': {'imdb_rating': '8.7', 'actors': 'Keanu Reeves, Laurence Fishburne', 'imdb_votes': '1600000'},
        'Goodfellas': {'imdb_rating': '8.7', 'actors': 'Robert DeNiro, Ray Liotta', 'imdb_votes': '900000'},
        'The Silence of the Lambs': {'imdb_rating': '8.6', 'actors': 'Jodie Foster, Anthony Hopkins', 'imdb_votes': '1200000'},
        'Schindler\'s List': {'imdb_rating': '9.0', 'actors': 'Liam Neeson, Ralph Fiennes', 'imdb_votes': '1100000'},
    }
    return demo_data.get(title, {'imdb_rating': 'N/A', 'actors': 'N/A', 'imdb_votes': 'N/A'})

def export_to_xml(df, filename):
    """Export DataFrame to XML file"""
    root = ET.Element('movies')
    
    for _, row in df.iterrows():
        movie = ET.SubElement(root, 'movie')
        
        for col in df.columns:
            # Escape special characters
            value = str(row[col]).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
            child = ET.SubElement(movie, col.lower().replace(' ', '_'))
            child.text = value
    
    # Pretty print XML
    xml_str = minidom.parseString(ET.tostring(root)).toprettyxml(indent="  ")
    # Remove the XML declaration line and extra blank lines
    xml_str = '\n'.join([line for line in xml_str.split('\n') if line.strip()])
    
    with open(filename, 'w', encoding='utf-8') as f:
        f.write(xml_str)

def main():
    # Read the CSV file
    df = pd.read_csv('movies.csv')
    
    # Add new columns
    df['IMDb Rating'] = ''
    df['Main Actors'] = ''
    df['IMDb Votes'] = ''
    
    # Print mode information
    if DEMO_MODE:
        print("Running in DEMO MODE with sample IMDb data")
        print("To use real data, get an API key from http://www.omdbapi.com/apikey.aspx")
        print("and set DEMO_MODE = False in main.py\n")
    else:
        print("Running with real OMDb API data\n")
    
    # Fetch data for each movie
    for index, row in df.iterrows():
        title = row['Title']
        year = int(row['Year'])
        print(f"Fetching data for {title} ({year})...")
        data = get_movie_data(title, year)
        df.at[index, 'IMDb Rating'] = data['imdb_rating']
        df.at[index, 'Main Actors'] = data['actors']
        df.at[index, 'IMDb Votes'] = data['imdb_votes']
        if not DEMO_MODE:
            time.sleep(0.5)  # Rate limiting to avoid hitting API too fast
    
    # Export to XML
    export_to_xml(df, 'movies_extended.xml')
    print(f"\nData exported to movies_extended.xml")
    
    # Save to CSV as well
    df.to_csv('movies_extended.csv', index=False)
    print(f"Data exported to movies_extended.csv")
    
    # Sort by IMDb Rating and get top 10
    # Convert rating to float for sorting, handle N/A
    df['IMDb Rating Numeric'] = pd.to_numeric(df['IMDb Rating'], errors='coerce')
    top_10 = df.sort_values(by='IMDb Rating Numeric', ascending=False).head(10)
    
    print("\n" + "="*60)
    print("Top 10 movies by IMDb Rating:")
    print("="*60)
    for i, (_, row) in enumerate(top_10.iterrows(), 1):
        print(f"{i}. {row['Title']} ({int(row['Year'])}) - Rating: {row['IMDb Rating']}")

if __name__ == "__main__":
    main()