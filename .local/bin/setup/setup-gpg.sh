#!/bin/sh

set -e

# todo add ability to create gpg key automatically
cat >keyfile <<EOF
%echo Generating a default key
Key-Type: default
Subkey-Type: default
Name-Real: My Name
Name-Comment: 
Name-Email: my@email.com
Expire-Date: 0
Passphrase: $PASSPHRASE
# Do a commit here, so that we can later print "done"
%commit
%echo done
EOF

gpg --batch --generate-key keyfile