import os

def print_folder_structure(path, indent=0):
    # Check if the given path is a directory
    if os.path.isdir(path):
        # Print the folder name
        print(" " * indent + "-- " + os.path.basename(path) + "/")
        # List all contents of the directory
        for item in os.listdir(path):
            item_path = os.path.join(path, item)
            # Recursive call for directories, or print the file name
            print_folder_structure(item_path, indent + 4)
    else:
        # Print the file name
        print(" " * indent + "-- " + os.path.basename(path))

# Specify the path you want to print
path_to_print = r"C:\Users\DELL\OneDrive\Bureau\ProjectSoftwareEngineering\developili\front_end\lib\icons"
print_folder_structure(path_to_print)
