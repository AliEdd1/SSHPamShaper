```
# SSH Bandwidth Shaping via PAM

This repository documents how to limit SSH users’ bandwidth on login using Linux traffic control (`tc`) and PAM session hooks.

## Overview

- A Bash script is used to apply a `tc` traffic shaping rule when an SSH session is opened.
- The same script removes the rule when the session is closed.
- The script is executed by PAM, so it runs automatically for SSH logins.
- Logging is written to `/var/log/bandwidth_limit.log`.

## File Locations

- **Script path (recommended):** `/etc/pam.d/ssh/shaper.sh`
  - Make sure it is executable:  
    ```bash
    chmod +x /etc/pam.d/ssh/shaper.sh
    ```

## Enabling PAM for SSH

In order for SSH to run the script on session open/close, SSH must be using PAM.

1. Edit **`/etc/ssh/sshd_config`** and ensure:
   ```text
   UsePAM yes
```
