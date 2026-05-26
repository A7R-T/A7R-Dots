#!/bin/bash

if systemctl is-active --quiet keyd; then
    sudo systemctl stop keyd
else
    sudo systemctl start keyd
fi
