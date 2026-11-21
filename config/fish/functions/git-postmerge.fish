function git-postmerge --description "Run post-merge actions on this branch"
	set src_branch (git branch --show-current 2>/dev/null)
	if test -z "$src_branch"
		echo "git-postmerge: not on a branch" >&2
		return 1
	end

	set -l pr
	switch (git remote get-url origin 2>/dev/null)
		case '*gitlab*'
			set pr (glab mr view -F json | jq -r '.state, .target_branch')
		case '*'
			set pr (gh pr view --json state,baseRefName --jq '.state, .baseRefName')
	end
	if test (count $pr) -ne 2
		echo "git-postmerge: no PR/MR found for $src_branch" >&2
		return 1
	end
	set -l state (string upper -- $pr[1])
	set -l dst_branch $pr[2]

	if test "$state" != MERGED
		echo "git-postmerge: PR/MR for $src_branch is $state, not MERGED" >&2
		return 1
	end

	if test -n "$(git status --porcelain --untracked-files=no)"
		echo "git-postmerge: uncommitted changes on $src_branch" >&2
		return 1
	end

	git fetch origin --prune
	and git switch "$dst_branch"
	and git pull --ff-only origin "$dst_branch"
	and git branch -D "$src_branch"
end
