# Defined in - @ line 1
function kill_other_mosh_sessions --description 'Kills all Mosh sessions except the current one.'
    kill (ps --no-headers --sort=start_time -C mosh-server -o pid | head -n -1);
end
