import subprocess
import os

def resolve_conflicts_accept_current():
    try:
        # Get the list of files with merge conflicts
        result = subprocess.run(
            ["git", "status", "--porcelain"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if result.returncode != 0:
            print(f"Error fetching git status: {result.stderr}")
            return
        
        # Extract conflicted files
        conflicted_files = [
            line[3:] for line in result.stdout.splitlines()
            if line.startswith("UU")  # UU indicates a conflict
        ]
        
        if not conflicted_files:
            print("No merge conflicts found.")
            return
        
        print(f"Conflicted files detected: {conflicted_files}")
        print(f"Resolving conflicts in {len(conflicted_files)} files...")

        # Function to resolve conflict by keeping current changes
        def resolve_file(file_path):
            with open(file_path, 'r') as file:
                content = file.read()
            
            # Remove the conflict markers and keep the current changes (HEAD)
            resolved_content = content.split('=======')[0]
            
            # Write the resolved content back to the file
            with open(file_path, 'w') as file:
                file.write(resolved_content)
            
            print(f"Resolved conflict in {file_path} using current changes.")
        
        # Resolve conflicts in each conflicted file
        for file in conflicted_files:
            resolve_file(file)
        
        # Stage all resolved files (force add to include ignored files)
        add_result = subprocess.run(
            ["git", "add", "-f"] + conflicted_files,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True
        )
        if add_result.returncode != 0:
            print(f"Error staging files: {add_result.stderr}")
        else:
            print("All conflicts resolved and staged successfully.")
    
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    resolve_conflicts_accept_current()
