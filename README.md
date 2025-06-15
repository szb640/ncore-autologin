# ncore-autologin

## Description

This script can be used to automatically login to `ncore.pro`, so that your account is not deleted due to inactivity.

## Usage

The script can be configured via command line arguments or environment variables. If both are defined, arguments take precedence.

| Argument | Argument (long) | Environment variable | Note                                        |
|----------|-----------------|----------------------|---------------------------------------------|
| -u       | --username      | NCORE_USERNAME       | Your username for logging into ncore.       |
| -p       | --password      | NCORE_PASSWORD       | Your password for logging into ncore.       |
| -l       | --location      | NCORE_LOCATION       | (Optional) The URL of the `login.php` page. |

