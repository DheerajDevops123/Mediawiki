def commands = [
    "cd /home/username",
    "wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz",
    "wget https://releases.wikimedia.org/mediawiki/1.41/mediawiki-1.41.1.tar.gz.sig",
    "gpg --verify mediawiki-1.41.1.tar.gz.sig mediawiki-1.41.1.tar.gz"
    "cd /var/www",
    "tar -zxf /home/username/mediawiki-1.41.1.tar.gz",
    "ln -s mediawiki-1.41.1/ mediawiki"
]