#!/bin/bash

bin="/app/bin/aht20"

eval "$bin eval \"Aht20.Release.migrate\""
exec "$bin" "start"
