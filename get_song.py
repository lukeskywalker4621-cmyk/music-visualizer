import tkinter as tk
from tkinter import filedialog
import json

def get_song():
    root = tk.Tk()
    root.withdraw()

    song = filedialog.askopenfilename(
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
            songs = json.load(json_file)
    except FileNotFoundError:
        songs = []
    except json.JSONDecodeError:
        print("songs.json is not valid JSON")
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