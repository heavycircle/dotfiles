function pf --description 'Port-forward: pf <remote> <port>'
	if test (count $argv) -ne 2
		echo "usage: pf <remote> <port>" >&2
		return 2
	end

	set --local remote "$argv[1]"
	set --local port "$argv[2]"

	if test -z "$remote"
		echo "pf: remote must not be empty" >&2
		return 2
	end

	if not string match --quiet --regex '^[0-9]+$' -- "$port"
		echo "pf: port must be a number, got '$port'" >&2
		return 2
	end

	if test "$port" -lt 1 -o "$port" -gt 65535
		echo "pf: port must be between 1 and 65535, got $port" >&2
		return 2
	end

	if not command --query ssh
		echo "pf: ssh not found in PATH" >&2
		return 127
	end

	if command --query ss; and ss -Hltn "sport = :$port" 2>/dev/null | string match --quiet --regex '.'
		echo "pf: local port $port is already in use" >&2
		return 1
	end

	ssh -N -o ExitOnForwardFailure=yes -L "$port:localhost:$port" "$remote"
	or begin
		set --local rc $status
		echo "pf: ssh exited with status $rc" >&2
		return $rc
	end
end
