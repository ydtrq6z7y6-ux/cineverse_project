import pytest
from unittest.mock import patch, mock_open
import pandas as pd
import sys
import os

# Add the parent directory to the path so we can import main
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from main import get_movie_data, get_demo_data, export_to_xml


class TestGetDemoData:
    """Test the demo data function"""

    def test_known_movie(self):
        """Test getting demo data for a known movie"""
        result = get_demo_data("The Shawshank Redemption", 1994)
        expected = {
            'imdb_rating': '9.3',
            'actors': 'Tim Robbins, Morgan Freeman',
            'imdb_votes': '2600000'
        }
        assert result == expected

    def test_unknown_movie(self):
        """Test getting demo data for an unknown movie"""
        result = get_demo_data("Unknown Movie", 2020)
        expected = {
            'imdb_rating': 'N/A',
            'actors': 'N/A',
            'imdb_votes': 'N/A'
        }
        assert result == expected


class TestGetMovieData:
    """Test the API data fetching function"""

    @patch('main.requests.get')
    def test_successful_api_call(self, mock_get):
        """Test successful API response"""
        mock_response = {
            'Response': 'True',
            'imdbRating': '8.5',
            'Actors': 'Actor1, Actor2',
            'imdbVotes': '100000'
        }
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = mock_response

        result = get_movie_data("Test Movie", 2020)
        expected = {
            'imdb_rating': '8.5',
            'actors': 'Actor1, Actor2',
            'imdb_votes': '100000'
        }
        assert result == expected

    @patch('main.requests.get')
    def test_movie_not_found(self, mock_get):
        """Test when movie is not found"""
        mock_response = {
            'Response': 'False',
            'Error': 'Movie not found!'
        }
        mock_get.return_value.status_code = 200
        mock_get.return_value.json.return_value = mock_response

        result = get_movie_data("Nonexistent Movie", 2020)
        expected = {
            'imdb_rating': 'N/A',
            'actors': 'N/A',
            'imdb_votes': 'N/A'
        }
        assert result == expected

    @patch('main.requests.get')
    def test_api_error(self, mock_get):
        """Test API error response"""
        mock_get.return_value.status_code = 401  # Unauthorized

        result = get_movie_data("Test Movie", 2020)
        expected = {
            'imdb_rating': 'N/A',
            'actors': 'N/A',
            'imdb_votes': 'N/A'
        }
        assert result == expected

    @patch('main.requests.get')
    def test_exception_handling(self, mock_get):
        """Test exception handling"""
        mock_get.side_effect = Exception("Network error")

        result = get_movie_data("Test Movie", 2020)
        expected = {
            'imdb_rating': 'N/A',
            'actors': 'N/A',
            'imdb_votes': 'N/A'
        }
        assert result == expected


class TestExportToXml:
    """Test XML export functionality"""

    @patch('main.ET.tostring')
    @patch('main.minidom.parseString')
    @patch('builtins.open', new_callable=mock_open)
    def test_xml_export(self, mock_file, mock_parse, mock_tostring):
        """Test XML export with mock data"""
        # Create test DataFrame
        data = {
            'Title': ['Movie1', 'Movie2'],
            'Year': [2020, 2021],
            'IMDb Rating': ['8.5', '7.2']
        }
        df = pd.DataFrame(data)

        # Mock the XML processing
        mock_tostring.return_value = b'<movies><movie>...</movie></movies>'
        mock_parse.return_value.toprettyxml.return_value = '<?xml version="1.0" ?>\n<movies>\n  <movie>\n    <title>Movie1</title>\n  </movie>\n</movies>\n'

        export_to_xml(df, 'test_output.xml')

        # Check that file was opened for writing
        mock_file.assert_called_once_with('test_output.xml', 'w', encoding='utf-8')

        # Check that write was called
        mock_file().write.assert_called_once()


if __name__ == "__main__":
    pytest.main([__file__])