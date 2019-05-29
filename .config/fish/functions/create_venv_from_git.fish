# Defined in - @ line 1
function create_venv_from_git --description 'Creates virtualenv and helping alias for activation from git repo.'
    virtualenv -p python3 ~/envs/$argv[1];
    source ~/envs/$argv[1]/bin/activate.fish && pip install pip-tools && deactivate;
    alias $argv[1]="source ~/envs/$argv[1]/bin/activate.fish  && cd ~/code/$argv[1]";
    funcsave $argv[1];
    git clone $argv[2] ~/code/$argv[1];
end
