#!/usr/bin/env sh
set -eu

DEFAULT_URL="https://ncore.pro/login.php"

USERNAME=${NCORE_USERNAME:-""}
PASSWORD=${NCORE_PASSWORD:-""}
URL=${NCORE_LOCATION:-DEFAULT_URL}

print_usage() {
    echo "Usage: $0 [-u|--username| <user>] [-p|--password <pass>]"
    echo "Arguments:"
    echo "  -u | --username    Your ncore username. Can be passed via NCORE_USERNAME environment variable."
    echo "  -p | --password    Your ncore password. Can be passed via NCORE_PASSWORD environment variable."
    echo "  -l | --location    (Optional) URL address of the login form. Can be passed via NCORE_LOCATION environment variable. Defaults to: ${DEFAULT_URL}"
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        -u|--username)
            USERNAME="$2"
            shift 2
            ;;
        -p|--password)
            PASSWORD="$2"
            shift 2
            ;;
        -l|--location)
            URL="$2"
            shift 2
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            print_usage
            exit 1
            ;;
    esac
done

if [ -z "$USERNAME" ]; then
    echo "ERROR: Username is missing! Please provide username." >&2
    exit 1
fi

if [ -z "$PASSWORD" ]; then
    echo "ERROR: Password is missing! Please provide password." >&2
    exit 1
fi

if ! curl -s "$URL" | grep -qEo '<form[^>]+id="login[^>]+>'; then
    echo "ERROR: Could not find login form. Please update url or script." >&2
    exit 2
fi

USERAGENT="$(curl -s "https://www.whatismybrowser.com/guides/the-latest-user-agent/chrome" | grep -Po '(?<=>)[^<]*Windows NT 10.0.*Chrome[^<]*(?=<)')"
if ! echo "$USERAGENT"| grep -q "Chrome"; then
    echo "ERROR: Invalid UserAgent (${USERAGENT}). Please update script." >&2
    exit 3
fi

CURLOUTPUT="$(curl -s "${URL}" -H "User-Agent: ${USERAGENT}" -c - --data-urlencode "nev=${USERNAME}" --data-urlencode "pass=${PASSWORD}" --location)"

if echo "$CURLOUTPUT" | grep -q 'Username or password did not match' || ! echo "$CURLOUTPUT" | grep -q "$USERNAME" ; then
        echo "ERROR: Username or password is incorrect. Please check your credentials." 
        exit 4
fi
