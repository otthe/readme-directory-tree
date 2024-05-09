# readme-directory-tree
Automatically updates a directory tree structure in your `README.md`. 

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
    <br>
2. **Run `treeview.sh` via CLI or automated action**
    <br><br>
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
