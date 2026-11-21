function stripext --description "Strip File Extensions"
	set --local file $argv[1]

	while path extension -q $file
		set file (path change-extension '' $file)
	end

	echo "$file"
end
