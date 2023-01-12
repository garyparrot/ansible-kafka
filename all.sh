function loading {
  # Stop Loading
  ansible-playbook -i inventory.ini -i producer-inventory.json -f 20 playbooks/loading.yml
  sleep 2
}

function cluster {
  # Restart cluster
  ansible-playbook -i inventory.ini playbooks/apache-kafka-cluster.yml
  sleep 2
}

function allocation {
  # Apply cluster
  (cd /home/garyparrot/Programming/astraea-copy && ./gradlew test --tests org.astraea.app.service.Whatever.*)
  sleep 2
}

function stop_loading {
  # Start Loading
  ansible-playbook -i inventory.ini -i producer-inventory.json -f 20 playbooks/stop-loading.yml
  sleep 2
}

function all {
    stop_loading
    cluster
    allocation
    loading
}

if [[ "$@" == "" ]]; then
    declare -f
else
    $@
fi
