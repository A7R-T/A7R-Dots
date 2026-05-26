#!/bin/bash
if systemctl is-active --quiet keyd; then
    echo '{"text": "", "class": "active"}'
else
    echo '{"text": "", "class": "inactive"}'
fi
