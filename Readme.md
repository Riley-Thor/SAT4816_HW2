
# Memory Search Script

This is a Bash script designed to analyze a memory dump using `volatility`. It provides multiple options to search for profile information, process IDs, process trees, network connections, and command executions from a given memory dump file.

## Prerequisites

- **Volatility**: Make sure you have the `vol.py` tool installed.
- **Bash**: This script is intended to be run in a Bash shell. Ensure you have Bash installed (typically available by default on most Unix-based systems).
- **Memory Dump File**: The script assumes a memory dump file named `memdumpWin7.mem` is available in the current working directory.

## Usage

```bash
./memory_search.sh <operation_type> <profile> <keyword>
```

### Parameters

1. **operation_type** (required): Specifies the type of operation to perform. Acceptable values are:
   - `0` - Search profile information (ignores `<profile>` and `<keyword>`)
   - `1` - Search for a specific process ID (list all PIDs if `<keyword>` is not provided)
   - `2` - Search for a process tree associated with an application
   - `3` - Search for network connections used by an application
   - `4` - Search for command execution

2. **profile** (required for operation types `1-4`): The profile name that corresponds to your memory image (e.g., `Win7SP1x86_23418`).

3. **keyword** (optional): A string or integer used to filter the results (e.g., a PID number, process name, or network connection). This is optional for operation types `1` and `4` but required for types `2` and `3`.

### Examples

1. **Search Profile Information**
   ```bash
   ./memory_search.sh 0
   ```

![Screenshot 2024-11-12 165708](https://github.com/user-attachments/assets/8e37f94b-db2e-4259-91ff-6127cbf6c0a6)
   
2. **Search for a Specific Process ID**
   ```bash
   ./memory_search.sh 1 Win7SP1x86_23418 1280
   ```
   - This searches for the process with PID `1280` using the `Win7SP1x86_23418` profile.

![Screenshot 2024-11-12 165841](https://github.com/user-attachments/assets/beb19218-a1e3-4c6d-bc56-44912d595967)

3. **List All Processes**
   ```bash
   ./memory_search.sh 1 Win7SP1x86_23418
   ```
   - Lists all processes without specifying a PID.

![Screenshot 2024-11-12 170000](https://github.com/user-attachments/assets/fdb23ed9-5b74-48fe-8b47-ea8da97fb6e4)

4. **Search for a Process Tree**
   ```bash
   ./memory_search.sh 2 Win7SP1x86_23418 chrome
   ```
   - This searches for the process tree associated with `chrome`.

![Screenshot 2024-11-12 170204](https://github.com/user-attachments/assets/8ccf9bcb-b46b-4987-b619-9dbbb990c18b)

5. **Search for Network Connections**
   ```bash
   ./memory_search.sh 3 Win7SP1x86_23418 sshd
   ```
   - This searches for network connections involving `sshd`.

![Screenshot 2024-11-12 170313](https://github.com/user-attachments/assets/3e3834e6-9b3e-4070-ad14-a668f2941c97)

6. **Search for Command Executions**
   ```bash
   ./memory_search.sh 4 Win7SP1x86_23418
   ```
   - Lists all command executions found in memory.

![Screenshot 2024-11-12 170421](https://github.com/user-attachments/assets/bf418248-5ade-4f6b-ba4d-282cbc816d9d)
   
   ```bash
   ./memory_search.sh 4 Win7SP1x86_23418 Cmd
   ```
   - Searches specifically for `Cmd` command executions.

![Screenshot 2024-11-12 170514](https://github.com/user-attachments/assets/276b22a9-adc1-4236-ad7a-fb92512fc65c)

### Common Errors

- **Bad Interpreter Error**:
  - If you encounter:
    ```
    zsh: ./memory_search.sh: bad interpreter: /bin/bash^M: no such file or directory
    ```
    This is caused by Windows-style line endings. Convert the script to Unix format using:
    ```bash
    dos2unix memory_search.sh
    ```

- **Permission Denied**:
  - If you see:
    ```
    bash: ./memory_search.sh: Permission denied
    ```
    Make the script executable:
    ```bash
    chmod +x memory_search.sh
    ```

## Author

Riley
