# CineVerse Movie Data Enrichment

This project extends the CineVerse festival movie dataset with additional data from IMDb using the OMDb API.

## Requirements

- Python 3.x
- requests
- pandas
- python-dotenv
- pytest (for testing)
- pytest-mock (for testing)

## Setup

1. Install dependencies:
   ```
   pip install requests pandas python-dotenv pytest pytest-mock
   ```

2. Get an API key from [OMDb API](http://www.omdbapi.com/apikey.aspx)

3. Create a `.env` file in the project root and add your API key:
   ```
   OMDB_API_KEY=your_actual_api_key_here
   ```

4. Place `movies.csv` in the project directory.

## Usage

Run the script:
```
python main.py
```

This will:
- Read movies from `movies.csv`
- Fetch additional data from OMDb API
- Save extended data to `movies_extended.xml`
- Display top 10 movies by IMDb rating

## Testing

Run the tests:
```
pytest
```

Or run with coverage:
```
pytest --cov=main --cov-report=html
```

## Output

- `movies_extended.xml`: Extended movie data in XML format
- Console output: Top 10 movies by IMDb rating