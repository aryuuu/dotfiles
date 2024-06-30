#!/usr/bin/env bash

db_name=$HOME/fatt_test

insert_task () {
    new_task=$(rofi -dmenu -i -p "Enter new task")
    current_task_id=$(sqlite3 $db_name "WITH latest_event AS \
            (SELECT * FROM events ORDER BY id DESC LIMIT 1) \
        SELECT COALESCE(tasks.id, 0) FROM tasks JOIN latest_event on tasks.id = latest_event.task_id \
        WHERE tasks.status = 'STARTED' OR tasks.status = 'CONTINUED';")

    echo "current_task_id"
    echo $current_task_id

    if [[ -z $current_task_id ]];
    then
        current_task_id='0'
    fi

    sqlite3 $db_name "\
        BEGIN TRANSACTION;

        UPDATE tasks \
            SET status = 'HOLD' \
            WHERE tasks.id = $current_task_id;\

        INSERT INTO events (task_id, type, timestamp) \
            VALUES ($current_task_id, 'HOLD', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        INSERT INTO tasks \
            (name, status, created_at, updated_at) \
            VALUES ('$new_task', 'STARTED', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'), STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        WITH latest_task AS (SELECT * FROM tasks ORDER BY id DESC LIMIT 1) \
            INSERT INTO events (task_id, type, timestamp) \
                VALUES ((SELECT id from latest_task), 'STARTED', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        COMMIT;"

}

update_task_status () {
    current_task_id=$(sqlite3 $db_name "WITH latest_event AS \
            (SELECT * FROM events ORDER BY id DESC LIMIT 1) \
        SELECT COALESCE(tasks.id, 0) FROM tasks JOIN latest_event on tasks.id = latest_event.task_id \
        WHERE tasks.status = 'STARTED' OR tasks.status = 'CONTINUED';")

    if [[ -z $current_task_id ]];
    then
        current_task_id='0'
    fi

    sqlite3 $db_name "\
        BEGIN TRANSACTION;

        UPDATE tasks \
            SET status = '$1' \
            WHERE tasks.id = $current_task_id;\

        INSERT INTO events (task_id, type, timestamp) \
            VALUES ($current_task_id, '$1', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        COMMIT;"

    sqlite3 $db_name "\
        BEGIN TRANSACTION;

        UPDATE tasks \
        SET status = \"$1\", updated_at = STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW') \
        FROM (SELECT id FROM tasks ORDER BY id DESC LIMIT 1) AS latest_task \
        WHERE status = 'STARTED';\

        COMMIT;"
}

continue_task () {
    current_task_id=$(sqlite3 $db_name "WITH latest_event AS \
            (SELECT * FROM events ORDER BY id DESC LIMIT 1) \
        SELECT COALESCE(tasks.id, 0) FROM tasks JOIN latest_event on tasks.id = latest_event.task_id \
        WHERE tasks.status = 'STARTED' OR tasks.status = 'CONTINUED';")

    if [[ -z $current_task_id ]];
    then
        current_task_id='0'
    fi

    selected_task_id=$(sqlite3 $db_name "SELECT id FROM tasks WHERE name = '$1' ORDER BY id DESC LIMIT 1;")

    sqlite3 $db_name "\
        BEGIN TRANSACTION;

        UPDATE tasks \
            SET status = 'HOLD' \
            WHERE tasks.id = $current_task_id;\

        INSERT INTO events (task_id, type, timestamp) \
            VALUES ($current_task_id, 'HOLD', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        UPDATE tasks \
            SET status = 'CONTINUED' \
            WHERE tasks.id = $selected_task_id;\

        INSERT INTO events (task_id, type, timestamp) \
            VALUES ($selected_task_id, 'CONTINUED', STRFTIME('%Y-%m-%d %H-%M-%S', 'NOW'));\

        COMMIT;"
}


default_options="DONE\nHOLD\nNEW"
tasks=$(sqlite3 $db_name "SELECT name FROM tasks WHERE status != 'DONE';")
pending_tasks=$(sqlite3 $db_name "SELECT name FROM tasks WHERE status = 'HOLD';")
options="$default_options\n$pending_tasks"

selection=$(echo -e $options | rofi -dmenu -i -p "Task")

case $selection in
    "NEW")
        insert_task
        ;;
    "DONE")
        update_task_status "DONE"
        ;;
    "HOLD")
        update_task_status "HOLD"
        ;;
    *)
        continue_task "$selection"
        ;;
esac


