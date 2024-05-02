// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MoviesManagement {
    struct Movie {
        string title;
        string director;
        uint256 releaseYear;
    }

    mapping(uint256 => Movie) public movies;
    uint256 public movieCount;

    function addMovie(string memory _title, string memory _director, uint256 _releaseYear) public {
        movies[movieCount] = Movie(_title, _director, _releaseYear);
        movieCount++;
    }

    function getMovie(uint256 _index) public view returns (string memory, string memory, uint256) {
        require(_index < movieCount, "Movie does not exist.");
        Movie memory movie = movies[_index];
        return (movie.title, movie.director, movie.releaseYear);
    }

    function deleteMovie(uint256 _index) public {
        require(_index < movieCount, "Invalid index.");

        // Directly delete the movie entry
        delete movies[_index];

        // Optional: If you want to keep all movies contiguous without gaps:
        // This will effectively move the last movie to the deleted slot and decrease the count
        if (_index != movieCount - 1) {
            movies[_index] = movies[movieCount - 1];
            delete movies[movieCount - 1];
        }
        movieCount--;
    }
}
