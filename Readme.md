
# Memory Search Script

This script is used to analyze a memory dump using `volatility`. It provides multiple options to search for profile information, process IDs, process trees, network connections, and command executions from a given memory dump file.

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


   
2. **Search for a Specific Process ID**
   ```bash
   ./memory_search.sh 1 Win7SP1x86_23418 1280
   ```
   - This searches for the process with PID `1234` using the `Win7SP1x86_23418` profile.



3. **List All Processes**
   ```bash
   ./memory_search.sh 1 Win7SP1x86_23418
   ```
   - Lists all processes without specifying a PID.



4. **Search for a Process Tree**
   ```bash
   ./memory_search.sh 2 Win7SP1x86_23418 chrome
   ```
   - This searches for the process tree associated with `chrome`.



5. **Search for Network Connections**
   ```bash
   ./memory_search.sh 3 Win7SP1x86_23418 sshd
   ```
   - This searches for network connections involving `sshd`.



6. **Search for Command Executions**
   ```bash
   ./memory_search.sh 4 Win7SP1x86_23418
   ```
   - Lists all command executions found in memory.


   
   ```bash
   ./memory_search.sh 4 Win7SP1x86_23418 Cmd
   ```
   - Searches specifically for `Cmd` command executions.



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

Riley Meeves