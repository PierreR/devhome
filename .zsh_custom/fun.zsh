function presources () {
    puppetresources -p . -o $1 --hiera ./tests/hiera.yaml --pdbfile ./tests/facts.yaml ${@:2}
}

function sshi () {
	ssh -A -i ~/.ssh/alhazen_rsa alhazen@$1
}

function ssrc () {
  git rev-list --all | GIT_PAGER=less xargs git grep $1
}
