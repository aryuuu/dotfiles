#!/usr/bin/env bash

current_task=$(sqlite3 $HOME/fatt_test "WITH latest_event AS \
        (SELECT * FROM events ORDER BY id DESC LIMIT 1) \
    SELECT tasks.name FROM tasks JOIN latest_event on tasks.id = latest_event.task_id \
    WHERE tasks.status = 'STARTED' OR tasks.status = 'CONTINUED';")

echo $current_task
