#!/bin/bash
PID=$(ps auxww | grep gpg-agent)
kill -9 $PID
