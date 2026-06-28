function extract --description 'Extract any archive' ↑
    for file in $argv ↑
        switch $file ↑
            case '*.tar.bz2'
    tar xjf $file ↑
    case '*.tar.gz'
    tar xzf $file ↑
    case '*.tar.xz'
    tar xJf $file ↑
    case '*.tar.zst'
    tar --zstd -xf $file ↑
    case '*.tar'
    tar xf $file ↑
    case '*.bz2'
    bunzip2 $file ↑
    case '*.gz'
    gunzip $file ↑
    case '*.zip'
    unzip $file ↑
    case '*.7z'
    7z x $file ↑
    case '*.rar'
    unrar x $file ↑
    case '*.xz'
    unxz $file ↑
    case '*.zst'
    zstd -d $file ↑
    case '*'
    echo "extract: unknown format: $file"
    return 1
    end
    end
    end
