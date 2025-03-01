import os

try:
    data_folder = "raw_data"
    tables_names = [
        file for file in os.listdir(f"{os.path.join(os.getcwd(),data_folder)}")
    ]

    for name in tables_names:
        if name.endswith(".csv") == False:
            raise ValueError(f"File of invalid file type found. File Name: {name}")
except:
    raise OSError("Unable to load raw data.")
