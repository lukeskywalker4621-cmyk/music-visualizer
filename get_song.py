import tkinter as tk
from tkinter import filedialog
import json
from pathlib import Path
import os
from ytmusicapi import YTMusic

def get_song_from_downloads():
    root = tk.Tk()
    root.withdraw()
    root.attributes('-topmost', True)

    song = filedialog.askopenfilename(
        initialdir=str(Path.home() / "Downloads"),
        title="Pick a song",
        filetypes=[
            ("Sound files", "*.mp3 *.wav"),
            ("All files", "*.*"),
        ],
    )

    root.destroy()

    if not song:  # User cancelled
        return None

    try:
        with open("songs.json", "r") as json_file:
            content = json_file.read().strip()  # Read as text first
            if content:  # Only parse if not empty
                songs = json.loads(content)
            else:
                songs = []  # Empty file = empty list
    except FileNotFoundError:
        songs = []
    except json.JSONDecodeError:
        print("songs.json is corrupted. Starting fresh.")
        songs = []

    # Check if song is already in the list
    if song not in songs:
        songs.append(song)
        with open("songs.json", "w") as json_file:
            json.dump(songs, json_file, indent=2)
        print(f"Added: {song}")
    else:
        print(f"Already in list: {song}")

    return song

def get_song(): # this is for songs not downloaded
    print("not working")
