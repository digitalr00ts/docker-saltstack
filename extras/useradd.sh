#!/bin/sh

echo "Adding default user: saltdev"
useradd --no-create-home --no-user-group --shell /sbin/nologin --gid saltapi --password '$6$wJCko5Bc$.SN0uWuO5yjaQHZbxX.gJ0o1h.cljyv9VBcbpSAGqU6IErmyK4AWJkhlg0QCrUhrBXTQ1.JzgTPkcqqkfOgLs/' saltdev

