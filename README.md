# readme-directory-tree
Helps you to maintain your project's README by automatically providing up-to-date directory structure in a treeview format.

## Features
- Automatically generates and updates directory structure in a `README.md` file.
- Configurable maximum depth for directory tree view.
- Excludes specified directories (e.g., `node_modules`, `.git`).
- Easy to plug into CI.

## Usage
1. **Include tags in your `README.md`:**
    ```bash
    <!-- TREEVIEW START -->
    <!-- TREEVIEW END -->
    ```
    
2. **Run `treeview.sh` via CLI or automated action**
    <br>
3. **You should see similar output in your README.md**
    <!-- TREEVIEW START -->
    ```bash
    ├── example-directory/
    │   ├── build/
    │   ├── scripts/
    │   ├── src/
    │   │   ├── backend/
    │   │   │   └── server/
    │   │   └── frontend/
    │   │       ├── js/
    │   │       └── styles/
    │   └── tests/
    ```

    <!-- TREEVIEW END -->

## Configuration
- `treeview.sh` accepts three parameters:
  1. **root directory:** (default: `.`)  
      Specifies the root directory from which to generate the tree view.

  2. **README.md path:** (default: `README.md` in the current directory)  
      Path to the `README.md` file where the tree view will be updated.

  3. **maximum depth:** (default: `-1` for unlimited depth)  
      Sets the maximum depth for directory traversal. For example:
      - `2` limits the depth to 2 levels.
      - `-1` means unlimited depth.

    ```bash
    ./treeview.sh [root_directory] [readme_path] [max_depth]
    ```

    **Examples:**
    - Generate a directory tree starting from the current directory and update the local `README.md`:
      ```bash
      ./treeview.sh
      ```
    - Specify a different root directory:
      ```bash
      ./treeview.sh some_directory
      ```
    - Specify a different `README.md` file:
      ```bash
      ./treeview.sh some_directory /path/to/another/README.md
      ```
    - Limit the tree view to a maximum depth of 2:
      ```bash
      ./treeview.sh some_directory /path/to/another/README.md 2
      ```

## Things to consider
This script hasn't been tested on macOS.
