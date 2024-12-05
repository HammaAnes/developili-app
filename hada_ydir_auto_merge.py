import os

def resolve_merge_conflicts(directory):
    """
    Automatically resolves merge conflicts by accepting current changes
    in all files with conflicts within the specified directory.
    """

    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)

            try:
                with open(file_path, 'r') as f:
                    lines = f.readlines()

                # Check if the file has merge conflict markers
                if any(conflict_start in line for line in lines):
                    resolved_lines = []
                    inside_conflict = False

                    for line in lines:
                        if conflict_start in line:
                            inside_conflict = True
                        elif conflict_middle in line and inside_conflict:
                            # Skip incoming changes
                            continue
                        elif conflict_end in line and inside_conflict:
                            inside_conflict = False
                        elif not inside_conflict:
                            resolved_lines.append(line)

                    # Write back the resolved lines to the file
                    with open(file_path, 'w') as f:
                        f.writelines(resolved_lines)

                    print(f"Resolved conflicts in: {file_path}")

            except Exception as e:
                print(f"Error processing file {file_path}: {e}")

if __name__ == "__main__":
    # Specify the root directory where the files are located
    directory = r'C:\Users\DELL\OneDrive\Bureau\ProjectSoftwareEngineering\developili'  # Change this to your repository's root folder
    resolve_merge_conflicts(directory)
