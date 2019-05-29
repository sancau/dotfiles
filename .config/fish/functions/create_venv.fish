# Defined in - @ line 1
function create_venv --description 'Creates virtualenv and helping alias for activation.'
    virtualenv -p python3 ~/envs/$argv;
    source ~/envs/$argv/bin/activate.fish && pip install pip-tools && deactivate;
    alias $argv="source ~/envs/$argv/bin/activate.fish  && cd ~/code/$argv";
    funcsave $argv;
    mkdir ~/code/$argv;
end
